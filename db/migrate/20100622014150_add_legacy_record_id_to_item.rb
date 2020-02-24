class AddLegacyRecordIdToItem < ActiveRecord::Migration[4.2]
  def self.up
    add_column :items, :legacy_record_id, :integer
  end

  def self.down
    remove_column :items, :legacy_record_id
  end
end
