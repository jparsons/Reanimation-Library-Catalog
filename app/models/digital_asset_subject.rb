class DigitalAssetSubject < ActiveRecord::Base
  
  has_and_belongs_to_many :digital_assets
  belongs_to :digital_asset_subject_authority
end
