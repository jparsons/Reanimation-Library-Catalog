require 'test_helper'

class LogEntryTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: log_entries
#
#  id             :integer         not null, primary key
#  process_log_id :integer
#  message        :text
#  created_at     :datetime
#  updated_at     :datetime
#

