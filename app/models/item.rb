class Item < ActiveRecord::Base
  def attributes_protected_by_default
    ['type']
  end
#  include AASM

  before_save :strip_dollar_signs

  def self.attributes_protected_by_default
      []
  end

  scope :published, -> { where("cataloging_status = 'published'") }
  scope :recent, -> { published.limit(15).order("published_at DESC").includes(:creators) }
  scope :by_call_number, -> { order("call_number ASC").includes(:creators) }
  scope :need_cataloging, -> { where("cataloging_status is null OR cataloging_status != 'published'") }

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

  mount_uploader :cover_image, CoverImageUploader, mount_on: :cover_image_file_name
  
  validates_presence_of :cover_image
  #has_one_attached :cover_image#, :whiny => false, :styles => { :thumb => "140x300>", :large =>"300x700>" }, :default_url => "/catalog/images/missing_:style_cover_image.png"
  #validates_attachment :cover_image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  acts_as_indexed :fields => [ :item_id, :display_title, :display_creator, :subject_list, :copyright, :image_color_list, :image_type_list, :is_public_domain, :collection_name ]

  before_save :create_title_for_alphabetizing

  def self.starting_with(letter)
    where("lower(alphabetical_title) LIKE ?", "#{letter.downcase}%").order("alphabetical_title")
  end

  def self.non_alphanumerical()
    where('alphabetical_title !~ ?', '^[a-zA-Z]').order(:alphabetical_title)
  end

  def self.previous(item)
    published.where("alphabetical_title < ?", item.alphabetical_title).limit(1).order("alphabetical_title desc")
  end

  def self.next(item)
    published.where("alphabetical_title > ?", item.alphabetical_title).limit(1).order("alphabetical_title")
  end

  def self.no_assets(order)
    left_outer_joins(:digital_assets).where("digital_assets.id is null AND items.collection_name = ?", "Primary").order(order)
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
