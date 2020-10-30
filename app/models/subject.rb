class Subject < ActiveRecord::Base
  def attributes_protected_by_default
    ['type']
  end
  has_and_belongs_to_many :items

  validates :name, uniqueness: { case_sensitive: false }
 
 
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

