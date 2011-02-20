class Item < ActiveRecord::Base
  include AASM
  
  def attributes_protected_by_default
      []
  end
  
  
  aasm_column :cataloging_status
  aasm_initial_state :acquired
  
  aasm_state :acquired
  aasm_state :images_added_but_needs_cataloging
  aasm_state :fully_cataloged_but_needs_images
  aasm_state :private
  aasm_state :published
  
  aasm_event :publish do
    transitions :to => :published, :from => [:acquired, :images_added_but_needs_images, :fully_cataloged_but_needs_images, :private, :published]
  end
  aasm_event :make_private do
    transitions :to => :private, :from => [:acquired, :images_added_but_needs_images, :fully_cataloged_but_needs_images, :private, :published]
  end
  
  default_scope :order => "alphabetical_title"
  named_scope :non_alphanumerical, {:conditions => "not (alphabetical_title like 'a%' or alphabetical_title like 'b%' or alphabetical_title like 'c%' or alphabetical_title like 'd%' or alphabetical_title like 'e%' or alphabetical_title like 'f%' or alphabetical_title like 'g%' or alphabetical_title like 'h%' or alphabetical_title like 'i%' or alphabetical_title like 'j%' or alphabetical_title like 'k%' or alphabetical_title like 'l%' or alphabetical_title like 'm%' or alphabetical_title like 'n%' or alphabetical_title like 'o%' or alphabetical_title like 'p%' or alphabetical_title like 'q%' or alphabetical_title like 'r%' or alphabetical_title like 's%' or alphabetical_title like 't%' or alphabetical_title like 'u%' or alphabetical_title like 'v%' or alphabetical_title like 'w%' or alphabetical_title like 'x%' or alphabetical_title like 'y%' or alphabetical_title like 'z%')", :order => "alphabetical_title"}
  named_scope :starting_with, lambda{|letter|{:conditions => ["alphabetical_title LIKE ?", "#{letter}%"], :order => "alphabetical_title"}}
  named_scope :previous, lambda { |item| {:conditions => ["alphabetical_title < ?", item.alphabetical_title], :limit => 1, :order => "alphabetical_title desc"} }
  named_scope :next, lambda { |item| {:conditions => ["alphabetical_title > ?", item.alphabetical_title], :limit => 1, :order => "alphabetical_title"} }
  named_scope :no_assets, {:conditions =>["digital_assets.id is null AND items.collection_name = ?", "1: Primary"], :include=>:digital_assets, :order=>"call_number"}
  named_scope :recent, { :limit=>15, :order => "created_at DESC", :include=>:creators }
  has_and_belongs_to_many :subjects
  has_and_belongs_to_many :donors
  has_many :digital_assets
  has_one :series_part
  has_one :series, :through=>:series_part
  belongs_to :vendor
  #has_one :vendor
  has_many :creators, :dependent=>:destroy
  has_and_belongs_to_many :works
  
  accepts_nested_attributes_for :subjects, :allow_destroy=>true  
  accepts_nested_attributes_for :creators, :allow_destroy=>true, :reject_if=> proc { |attributes| attributes.all? {|k,v| v.blank?} }
  accepts_nested_attributes_for :donors, :allow_destroy=>true, :reject_if=> proc { |attributes| attributes.all? {|k,v| v.blank?} }

  accepts_nested_attributes_for :vendor
  
  
  has_attached_file :cover_image, :styles => { :thumb => "140x300>", :large =>"300x700>" }, :default_url => "/catalog/images/missing_:style_cover_image.png"

  acts_as_ferret :fields => [ :title, :subtitle, :subject_list ]
  
  before_save :create_title_for_alphabetizing
  
  def display_title
    "#{title}#{subtitle.blank? ? "" : " " + subtitle}"
  end
  def display_creator
    creators.blank? ? "" : creators.first.display_name + (creators.size > 1 ? " et al." : "") 
  end
  
  def create_title_for_alphabetizing
    what_to_remove = REMOVE_FROM_BEGINNING_OF_TITLES.map{|w| "^#{w}" }.join("|")
    r = Regexp.new(what_to_remove,true)
    self.alphabetical_title = title.gsub(r, "").strip
  end
  
  def subject_list 
    subjects.map{|s| s.name }.join(",")
  end
  
  def self.search(params = {})
    if params[:q].blank?
      self.all
    else
      self.find_with_ferret(params[:q])
    end
    
    
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

