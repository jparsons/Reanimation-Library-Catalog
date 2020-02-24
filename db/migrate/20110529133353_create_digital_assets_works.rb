class CreateDigitalAssetsWorks < ActiveRecord::Migration[4.2]
  def self.up
    create_table :digital_assets_works, :id=>false do |t|
     t.integer :digital_asset_id
     t.integer :work_id
    end
  end

  def self.down
    drop_table :digital_assets_works
  end
end
