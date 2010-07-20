class ExhibitionVenue < ActiveRecord::Base
  has_many :exhibitions
end

# == Schema Information
#
# Table name: exhibition_venues
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  address_line_one   :string(255)
#  address_line_two   :string(255)
#  city               :string(255)
#  state              :string(255)
#  zipcode            :string(255)
#  country            :string(255)
#  phone              :string(255)
#  contact_first_name :string(255)
#  contact_last_name  :string(255)
#  contact_position   :string(255)
#  contact_email      :string(255)
#  website            :string(255)
#  notes              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

