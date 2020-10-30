class LogEntry < ActiveRecord::Base
  def attributes_protected_by_default
    ['type']
  end
  belongs_to :process_log
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

