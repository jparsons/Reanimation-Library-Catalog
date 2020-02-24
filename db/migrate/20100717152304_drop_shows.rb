class DropShows < ActiveRecord::Migration[4.2]
  def self.up
    drop_table :shows
  end

  def self.down
    create_table :shows do |t|
      t.date :start_date
      t.date :end_date
      t.string :location

      t.timestamps
    end
  end
end
