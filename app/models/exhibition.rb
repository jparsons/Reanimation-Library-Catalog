class Exhibition < ActiveRecord::Base
  belongs_to :exhibition_venue
  has_and_belongs_to_many :works
  
  accepts_nested_attributes_for :exhibition_venue
  accepts_nested_attributes_for :works
  
end


# == Schema Information
#
# Table name: exhibitions
#
#  id                  :integer         not null, primary key
#  title               :string(255)
#  start_date          :date
#  end_date            :date
#  exhibition_venue_id :integer
#  created_at          :datetime
#  updated_at          :datetime
#

