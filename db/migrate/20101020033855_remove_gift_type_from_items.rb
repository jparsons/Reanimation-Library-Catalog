class RemoveGiftTypeFromItems < ActiveRecord::Migration[4.2]
  def self.up
    remove_column :items, :gift_type
  end

  def self.down
    add_column :items, :gift_type, :string
  end
end
