class CreateShows < ActiveRecord::Migration[4.2]
  def self.up
    create_table :shows do |t|
      t.date :start_date
      t.date :end_date
      t.string :location

      t.timestamps
    end
  end

  def self.down
    drop_table :shows
  end
end
