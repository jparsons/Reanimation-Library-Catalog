class Vendor < ActiveRecord::Base
  has_many :items
  attr_accessible :name, :street, :city, :state, :zip, :country, :url, :phone, :notes
end
