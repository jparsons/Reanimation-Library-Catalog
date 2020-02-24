class AddLegacyIdToWorks < ActiveRecord::Migration[4.2]
  def self.up
    add_column :works, :legacy_id, :integer
  end

  def self.down
    remove_column :works, :legacy_id
  end
end
