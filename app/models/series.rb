class Series < ActiveRecord::Base
  has_many :series_parts
  has_many :items, :through=>:series_parts
end
