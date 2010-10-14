class CreateProcessLogs < ActiveRecord::Migration
  def self.up
    create_table :process_logs do |t|
      t.date_time :start_time
      t.date_time :end_time
      t.timestamps
    end
  end

  def self.down
    drop_table :process_logs
  end
end
