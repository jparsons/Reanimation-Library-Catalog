class CreateImageTypes < ActiveRecord::Migration[4.2]
  def self.up
    create_table :image_types do |t|
      t.string :name
      t.timestamps
    end
   create_table :digital_assets_image_types, :id=>false do |t|
      t.integer :digital_asset_id
      t.integer :image_type_id
   end
  end

  def self.down
    drop_table :image_types
    drop_table :digital_assets_image_types
  end
end
