class AddStartTimeAndEndTimeToProcessLogs < ActiveRecord::Migration
  def self.up
    add_column :process_logs, :start_time, :datetime
    add_column :process_logs, :end_time, :datetime
  end

  def self.down
    remove_column :process_logs, :end_time
    remove_column :process_logs, :start_time
  end
end
