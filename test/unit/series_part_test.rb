require 'test_helper'

class SeriesPartTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: series_parts
#
#  id                :integer         not null, primary key
#  item_id           :integer
#  series_id         :integer
#  position          :integer
#  volume_identifier :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

