class CreateLogEntries < ActiveRecord::Migration[4.2]
  def self.up
    create_table :log_entries do |t|
      t.integer :process_log_id
      t.text :message
      t.timestamps
    end
  end

  def self.down
    drop_table :log_entries
  end
end
