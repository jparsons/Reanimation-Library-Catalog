class Creator < ActiveRecord::Base
  belongs_to :item
  def display_name
    last_name + ", " + first_name + (middle_name.blank? ? "" : ", " + middle_name) + " (" + creator_type + ")"
  end
end
