class CreateExhibitions < ActiveRecord::Migration
  def self.up
     create_table :exhibitions do |t|
        t.string :title
        t.date :start_date
        t.date :end_date
        t.integer :exhibition_venue_id

        t.timestamps
      end
  end

  def self.down
    drop_table :exhibitions
  end
end
