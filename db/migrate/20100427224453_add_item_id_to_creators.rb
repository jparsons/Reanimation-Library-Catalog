class AddItemIdToCreators < ActiveRecord::Migration[4.2]
  def self.up
    add_column :creators, :item_id, :integer
  end

  def self.down
    remove_column :creators, :item_id
  end
end
