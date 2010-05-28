class Series < ActiveRecord::Base
  has_many :series_parts
  has_many :items, :through=>:series_parts
end

# == Schema Information
#
# Table name: series
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

