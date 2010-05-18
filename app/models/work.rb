class Work < ActiveRecord::Base
  attr_accessible :title, :medium, :size, :year_created, :genre
  has_and_belongs_to_many :items
end
