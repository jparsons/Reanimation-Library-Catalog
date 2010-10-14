class RemoveStartTimeAndEndTimeFromProcessLogs < ActiveRecord::Migration
  def self.up
    remove_column :process_logs, :start_time
    remove_column :process_logs, :end_time
  end

  def self.down
  end
end
