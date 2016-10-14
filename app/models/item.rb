class Item < ActiveRecord::Base
#  include AASM

  before_save :strip_dollar_signs

  def self.attributes_protected_by_default
      []
  end
  # aasm :column => :cataloging_status, :enum => true do
  #   state :acquired, initial: true
  #
  #   state :acquired, :include=>:subjects
  #   state :images_added_but_needs_cataloging
  #   state :fully_cataloged_but_needs_images
  #   state :unpublished
  #   state :published, :include=>:subjects
  #
  #   event :publish do
  #     transitions :to => :published, :from => [:acquired, :images_added_but_needs_images, :fully_cataloged_but_needs_images, :unpublished, :published]
  #   end
  #   event :make_unpublished do
  #     transitions :to => :unpublished, :from => [:acquired, :images_added_but_needs_images, :fully_cataloged_but_needs_images, :unpublished, :published]
  #   end
  # end
  scope :published, -> { where("cataloging_status = 'published'") }
  scope :recent, -> { published.limit(15).order("published_at DESC").includes(:creators) }
  scope :by_call_number, -> { order("call_number ASC").includes(:creators) }
  scope :need_cataloging, -> { where("cataloging_status != 'published'") }

  has_and_belongs_to_many :subjects
  has_and_belongs_to_many :donors
  has_many :digital_assets
  has_one :series_part
  has_one :series, :through=>:series_part
  belongs_to :vendor
  #has_one :vendor
  has_many :creators, :dependent=>:destroy
  has_and_belongs_to_many :works
  has_and_belongs_to_many :languages
  has_and_belongs_to_many :image_colors
  has_and_belongs_to_many :image_types

  accepts_nested_attributes_for :subjects, :allow_destroy=>true
  accepts_nested_attributes_for :creators, :allow_destroy=>true, :reject_if=> proc { |attributes| attributes.all? {|k,v| v.blank?} }
  accepts_nested_attributes_for :donors, :allow_destroy=>true, :reject_if=> proc { |attributes| attributes.all? {|k,v| v.blank?} }

  accepts_nested_attributes_for :vendor


  has_attached_file :cover_image, :whiny => false, :styles => { :thumb => "140x300>", :large =>"300x700>" }, :default_url => "/catalog/images/missing_:style_cover_image.png"
  validates_attachment :cover_image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  acts_as_indexed :fields => [ :item_id, :display_title, :display_creator, :subject_list, :copyright, :image_color_list, :image_type_list, :is_public_domain, :collection_name ]
  #acts_as_ferret :fields => [ :display_title, :display_creator, :subject_list, :copyright, :image_colors, :image_types, :is_public_domain ]

  before_save :create_title_for_alphabetizing

  def self.starting_with(letter)
    where("alphabetical_title LIKE ?", "#{letter}%").order("alphabetical_title")
  end

  def self.non_alphanumerical()
    where("not (alphabetical_title like 'a%' or alphabetical_title like 'b%' or alphabetical_title like 'c%' or alphabetical_title like 'd%' or alphabetical_title like 'e%' or alphabetical_title like 'f%' or alphabetical_title like 'g%' or alphabetical_title like 'h%' or alphabetical_title like 'i%' or alphabetical_title like 'j%' or alphabetical_title like 'k%' or alphabetical_title like 'l%' or alphabetical_title like 'm%' or alphabetical_title like 'n%' or alphabetical_title like 'o%' or alphabetical_title like 'p%' or alphabetical_title like 'q%' or alphabetical_title like 'r%' or alphabetical_title like 's%' or alphabetical_title like 't%' or alphabetical_title like 'u%' or alphabetical_title like 'v%' or alphabetical_title like 'w%' or alphabetical_title like 'x%' or alphabetical_title like 'y%' or alphabetical_title like 'z%')").order(:alphabetical_title)
  end

  def self.previous(item)
    published.where("alphabetical_title < ?", item.alphabetical_title).limit(1).order("alphabetical_title desc")
  end

  def self.next(item)
    published.where("alphabetical_title > ?", item.alphabetical_title).limit(1).order("alphabetical_title")
  end

  def self.no_assets(order)
    where("digital_assets.id is null AND items.collection_name = ?", "Primary").includes(:digital_assets).order(order)
  end

  def display_title
    "#{title}#{subtitle.blank? ? "" : " " + subtitle}"
  end

  def display_title_with_colon
    "#{title}#{subtitle.blank? ? "" : ": " + subtitle}"
  end

  def display_creator
    creators.blank? ? "" : creators.first.display_name + (creators.size > 1 ? " et al." : "")
  end

  def image_color_list
    image_colors.map(&:name).join(",")
  end

  def image_type_list
    image_types.map(&:name).join(",")
  end

  def create_title_for_alphabetizing
    what_to_remove = REMOVE_FROM_BEGINNING_OF_TITLES.map{|w| "^#{w}" }.join("|")
    r = Regexp.new(what_to_remove,true)
    self.alphabetical_title = title.gsub(r, "").strip
  end

  def item_id
    id.to_s
  end
  def subject_list
    subjects.map{|s| s.name }.join(",")
  end

  def self.search(query = "", logged_in = false)
    if logged_in
      self.includes(:subjects, :creators, :image_types, :image_colors).find_with_index(query)
    else
       self.includes(:subjects, :creators, :image_types, :image_colors).find_with_index(query)
    end
  end

  def is_public_domain
    is_public_domain?.to_s
  end

  def is_public_domain?
    if copyright.to_i < 1924 || is_government_document?
      true
    else
      false
    end
  end

  def vendor_location
    vendor.nil? ? '' : [vendor.city, vendor.state.try(:upcase)].join(", ")
  end

  def creator_count
    count = self.creators.count
    count += 1 unless self.corporate_author.blank?
    return count
  end

  def unpublished?
    !published?
  end

  def published?
    cataloging_status == 'published'
  end



  private

  def strip_dollar_signs
    self.price_paid = self.price_paid.to_s.gsub(/\$/, '').to_f
  end

end


# == Schema Information
#
# Table name: items
#
#  id                          :integer         not null, primary key
#  title                       :string(255)
#  created_at                  :datetime
#  updated_at                  :datetime
#  alphabetical_title          :string(255)
#  subtitle                    :string(255)
#  publisher_name              :string(255)
#  publisher_city              :string(255)
#  publisher_state             :string(255)
#  publisher_country           :string(255)
#  extent                      :string(255)
#  copyright                   :string(255)
#  item_size                   :string(255)
#  call_number                 :string(255)
#  collection_name             :string(255)
#  legacy_id                   :integer
#  cover_image_file_name       :string(255)
#  cover_image_content_type    :string(255)
#  cover_image_image_file_size :integer
#  cover_image_updated_at      :datetime
#  barcode                     :string(255)
#  has_marc_record             :boolean
#  metadata_notes              :text
#  corporate_author            :string(255)
#  isbn_issn                   :string(255)
#  language_id                 :integer
#  is_government_document      :boolean
#  edition                     :string(255)
#  notes                       :text
#  series_name                 :string(255)
#  needs_translation           :boolean
#  location                    :string(255)
#  is_marked                   :boolean
#  vendor_id                   :integer
#  date_acquired               :date
#  price_paid                  :decimal(, )
#  acquisition_type            :string(255)
#  acquisition_note            :text
#  acquired_for                :string(255)
#  legacy_record_id            :integer
#  cataloging_status           :string(255)
#  provenance                  :string(255)
#  dedication                  :text
#  language                    :string(255)
#  format                      :string(255)
#
