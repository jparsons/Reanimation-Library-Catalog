class Work < ActiveRecord::Base
  attr_accessible :title, :medium, :size, :year_created, :genre
  has_and_belongs_to_many :items
  has_and_belongs_to_many :exhibitions
end

# == Schema Information
#
# Table name: works
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  medium       :string(255)
#  size         :string(255)
#  year_created :integer
#  genre        :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

