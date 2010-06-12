class DigitalAsset < ActiveRecord::Base
  
  belongs_to :item
  has_and_belongs_to_many :digital_asset_subjects
  
  
  # need to update these sizes
  has_attached_file :scan,
    :styles => {
      :thumb=> "100x100#",
      :small  => "150x150>",
      :medium => "300x300>",
      :large =>   "400x400>" }
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

