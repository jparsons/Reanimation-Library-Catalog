class AddCatalogingStatusToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :cataloging_status, :string
  end

  def self.down
    remove_column :items, :cataloging_status
  end
end
