class Donor < ActiveRecord::Base
  has_and_belongs_to_many :items
  before_save :add_last_name

  validate :presence_of_name_or_organization_name
  validates :name, uniqueness: { case_sensitive: false }
  validates :organization_name, uniqueness: { case_sensitive: false }

  default_scope :order=>"last_name asc"

  def display_name
    name || organization_name
  end

private
  def add_last_name
    self.last_name = name.split.last || organization_name
  end

  def presence_of_name_or_organization_name
	  if name.blank? && organization_name.blank?
	    errors.add(:base, "Specify a name or organization name")
	  end
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

