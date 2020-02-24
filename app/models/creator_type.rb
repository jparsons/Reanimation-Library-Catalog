class CreatorType < ActiveRecord::Base
	has_many :creators
	validates :name, :presence => true
end
