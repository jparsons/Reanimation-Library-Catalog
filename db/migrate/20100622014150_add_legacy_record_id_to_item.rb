class AddLegacyRecordIdToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :legacy_record_id, :integer
  end

  def self.down
    remove_column :items, :legacy_record_id
  end
end
