class AddLegacyIdToWorks < ActiveRecord::Migration
  def self.up
    add_column :works, :legacy_id, :integer
  end

  def self.down
    remove_column :works, :legacy_id
  end
end
