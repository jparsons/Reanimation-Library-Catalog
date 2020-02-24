class AddLegacyIdToVendors < ActiveRecord::Migration[4.2]
  def self.up
    add_column :vendors, :legacy_id, :integer
    
  end

  def self.down
    drop_column :vendors, :legacy_id
  end
end
