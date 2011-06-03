class AddImageTypesItems < ActiveRecord::Migration
  def self.up
    create_table :image_types_items, :id=>false do |t|
      t.integer :image_type_id
      t.integer :item_id
    end
  end

  def self.down
    drop_table :image_types_items
  end
end
