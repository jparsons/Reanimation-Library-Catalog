class AddIsMarkedToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :marked, :boolean
  end

  def self.down
    remove_column :items, :marked
  end
end
