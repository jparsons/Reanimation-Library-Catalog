class Donor < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :organization_name
  has_and_belongs_to_many :items
end
