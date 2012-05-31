class DigitalAsset < ActiveRecord::Base

  belongs_to :item
  has_and_belongs_to_many :digital_asset_subjects
  has_and_belongs_to_many :works
  has_and_belongs_to_many :image_types

  accepts_nested_attributes_for :digital_asset_subjects


  # need to update these sizes
  has_attached_file :scan,
    :whiny => false,
    :styles => {
      :mini=> "59x59#",
      :thumb=> "136x136#",
      :large =>   "400x400>",
      }

  default_scope :order => "scan_file_name DESC"

  #default_scope :joins=>:item, :order=>"items.alphabetical_title, legacy_id"

  scope :most_recent, :order=>"created_at DESC", :limit=>100
  scope :published, where("items.cataloging_status='published'").joins(:item)

  def mini_url
      RECENT_IMAGES_PATH +  scan.url(:mini)

  end

  def self.previous(digital_asset)
    where("scan_file_name > ?", digital_asset.scan_file_name).limit(1).order("scan_file_name desc")
  end

  def self.next(digital_asset)
    where("scan_file_name < ?", digital_asset.scan_file_name).limit(1).order("scan_file_name")
  end

end


# == Schema Information
#
# Table name: digital_assets
#
#  id                :integer         not null, primary key
#  color             :string(255)
#  image_type        :string(255)
#  legacy_id         :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  scan_file_name    :string(255)
#  scan_content_type :string(255)
#  scan_file_size    :integer
#  item_id           :integer
#  is_marked         :boolean
#  page              :string(255)
#

