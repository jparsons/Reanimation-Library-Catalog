class CreateDigitalAssetIngests < ActiveRecord::Migration[4.2]
  def self.up
    create_table :digital_asset_ingests do |t|
      t.date :date
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :digital_asset_ingests
  end
end
