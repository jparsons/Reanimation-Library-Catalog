class DigitalAsset < ActiveRecord::Base
  
  belongs_to :item
  has_and_belongs_to_many :digital_asset_subjects
  has_and_belongs_to_many :works
  
  accepts_nested_attributes_for :digital_asset_subjects
  
  
  # need to update these sizes
  has_attached_file :scan,
    :styles => {
      :thumb=> "100x100#",
      :large =>   "400x00>" }
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
#

