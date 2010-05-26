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
