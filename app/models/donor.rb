class Donor < ActiveRecord::Base
  has_and_belongs_to_many :items
  default_scope :order=>"name asc" 

  def display_name
    name || organization_name
  end
end


# == Schema Information
#
# Table name: donors
#
#  id                :integer         not null, primary key
#  organization_name :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  name              :string(255)
#

