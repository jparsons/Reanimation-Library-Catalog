class Donor < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :organization_name
  has_and_belongs_to_many :items
end

# == Schema Information
#
# Table name: donors
#
#  id                :integer         not null, primary key
#  first_name        :string(255)
#  last_name         :string(255)
#  organization_name :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

