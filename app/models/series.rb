class Series < ActiveRecord::Base
  def attributes_protected_by_default
    ['type']
  end
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

