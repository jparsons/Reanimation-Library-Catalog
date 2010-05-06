class Creator < ActiveRecord::Base
  belongs_to :item
  def display_name
    last_name + ", " + first_name + (middle_name.blank? ? "" : ", " + middle_name) + " (" + creator_type + ")"
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

