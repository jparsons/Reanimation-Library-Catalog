class Vendor < ActiveRecord::Base
  has_many :items
  attr_accessible :name, :street, :city, :state, :zip, :country, :url, :phone, :notes
end


# == Schema Information
#
# Table name: vendors
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  street     :string(255)
#  city       :string(255)
#  state      :string(255)
#  zip        :string(255)
#  country    :string(255)
#  url        :string(255)
#  phone      :string(255)
#  notes      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  legacy_id  :integer
#

