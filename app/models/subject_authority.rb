class SubjectAuthority < ActiveRecord::Base
  attr_accessible :name
  has_many :subjects
end

# == Schema Information
#
# Table name: subject_authorities
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

