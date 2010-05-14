class AddLegacyIdToVendors < ActiveRecord::Migration
  def self.up
    add_column :vendors, :legacy_id, :integer
    
  end

  def self.down
    drop_column :vendors, :legacy_id
  end
end
