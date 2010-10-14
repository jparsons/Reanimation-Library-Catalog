class AddDigitalAssetIngestIdToProcessLogs < ActiveRecord::Migration
  def self.up
    add_column :process_logs, :digital_asset_ingest_id, :integer
  end

  def self.down
    remove_column :process_logs, :digital_asset_ingest_id
  end
end
