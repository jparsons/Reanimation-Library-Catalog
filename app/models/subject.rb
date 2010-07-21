class Subject < ActiveRecord::Base
  has_and_belongs_to_many :items
end




# == Schema Information
#
# Table name: subjects
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  authority  :string(255)
#

