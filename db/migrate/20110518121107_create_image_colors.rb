class CreateImageColors < ActiveRecord::Migration
  def self.up
    create_table :image_colors do |t|
      t.string :name

      t.timestamps
    end
    create_table :image_colors_items, :id=>false do |t|
      t.integer :image_color_id
      t.integer :item_id
    end
  end

  def self.down
    drop_table :image_colors
    drop_table :image_colors_items
  end
end
