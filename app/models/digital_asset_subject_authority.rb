class DigitalAssetSubjectAuthority < ActiveRecord::Base
  has_many :digital_asset_subjects
end

# == Schema Information
#
# Table name: digital_asset_subject_authorities
#
#  id         :integer         not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)
#

