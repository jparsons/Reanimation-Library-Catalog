class AddDigitalAssetIngestIdToProcessLogs < ActiveRecord::Migration[4.2]
  def self.up
    add_column :process_logs, :digital_asset_ingest_id, :integer
  end

  def self.down
    remove_column :process_logs, :digital_asset_ingest_id
  end
end
