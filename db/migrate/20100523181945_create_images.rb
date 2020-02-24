class CreateImages < ActiveRecord::Migration[4.2]
  def self.up
    create_table :images, :force=>true do |t|
      t.belongs_to :item
      t.string :color
      t.string :image_type
      t.string :legacy_id
      t.boolean :is_marked
      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
