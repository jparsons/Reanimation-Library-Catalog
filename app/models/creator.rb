class Creator < ActiveRecord::Base
  belongs_to :item
  belongs_to :creator_type

  validate :presence_of_name

  def display_name
    name = [first_name, middle_name, last_name].join(" ")
    name += " (#{creator_type.try(:name)})" if (creator_type && name)
    return name
  end

  def old_creator_type
    self[:creator_type]
  end

  def presence_of_name
      errors.add :base, "Name fields cannot all be blank" if display_name.blank?
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
