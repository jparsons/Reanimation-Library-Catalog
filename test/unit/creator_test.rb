require 'test_helper'

class CreatorTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
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

