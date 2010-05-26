class AddItemIdToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :item_id, :integer
  end

  def self.down
    remove_column :images, :item_id
  end
end
