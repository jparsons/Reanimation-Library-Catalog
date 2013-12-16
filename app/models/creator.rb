class Creator < ActiveRecord::Base
  belongs_to :item
  belongs_to :creator_type

  def display_name
    name = first_name + (middle_name.blank? ? "" : " " + middle_name) + " " + last_name
    name += " (#{creator_type.name})" if creator_type
    return name
  end
end

# == Schema Information
#
# Table name: creators
#
#  id           :integer         not null, primary key
#  first_name   :string(255)
#  last_name    :string(255)
#  middle_name  :string(255)
#  name_suffix  :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  creator_type :string(255)
#  item_id      :integer
#

