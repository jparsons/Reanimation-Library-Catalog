class DigitalAssetSubject < ActiveRecord::Base
  
  has_and_belongs_to_many :digital_assets
  belongs_to :digital_asset_subject_authority
end

# == Schema Information
#
# Table name: digital_asset_subjects
#
#  id                                 :integer         not null, primary key
#  name                               :string(255)
#  digital_asset_subject_authority_id :integer
#  created_at                         :datetime
#  updated_at                         :datetime
#

