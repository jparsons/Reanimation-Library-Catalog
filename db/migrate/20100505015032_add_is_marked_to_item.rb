class AddIsMarkedToItem < ActiveRecord::Migration[4.2]
  def self.up
    add_column :items, :marked, :boolean
  end

  def self.down
    remove_column :items, :marked
  end
end
