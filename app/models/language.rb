class Language < ActiveRecord::Base
  attr_accessible :name
  has_many :items
end

# == Schema Information
#
# Table name: languages
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

