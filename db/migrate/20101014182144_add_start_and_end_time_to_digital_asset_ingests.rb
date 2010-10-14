class AddStartAndEndTimeToDigitalAssetIngests < ActiveRecord::Migration
  def self.up
    add_column :digital_asset_ingests, :start_time, :datetime
    add_column :digital_asset_ingests, :end_time, :datetime
    remove_column :digital_asset_ingests, :date
  end

  def self.down
    remove_column :digital_asset_ingests, :end_time
    remove_column :digital_asset_ingests, :start_time
    add_column :digital_asset_ingests, :date, :datetime
  end
end
