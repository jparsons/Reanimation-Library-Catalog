class AddItemIdToCreators < ActiveRecord::Migration
  def self.up
    add_column :creators, :item_id, :integer
  end

  def self.down
    remove_column :creators, :item_id
  end
end
