class CreateSeriesParts < ActiveRecord::Migration[4.2]
  def self.up
    create_table :series_parts do |t|
      t.integer :item_id
      t.integer :series_id
      t.integer :position
      t.string :volume_identifer

      t.timestamps
    end
  end

  def self.down
    drop_table :series_parts
  end
end
