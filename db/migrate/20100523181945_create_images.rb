class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images, :force=>true do |t|
      t.belongs :item
      t.string :color
      t.string :image_type
      t.string :legacy_id
      t.true :is_marked
      t.timestamps
    end
  end
  
  def self.down
    drop_table :images
  end
end
