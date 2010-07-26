class Subject < ActiveRecord::Base
  has_and_belongs_to_many :items
 
  def to_param  # overridden
    "#{id}-#{name.gsub(/[^a-z0-9]+/i, '-').downcase}"
  end

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

