class AddCatalogingStatusToItems < ActiveRecord::Migration[4.2]
  def self.up
    add_column :items, :cataloging_status, :string
  end

  def self.down
    remove_column :items, :cataloging_status
  end
end
