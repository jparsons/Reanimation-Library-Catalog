class ChangeMarkedToIsMarkedOnItem < ActiveRecord::Migration
  def self.up
    remove_column :items, :marked
    add_column :items, :is_marked, :boolean
  end

  def self.down
    add_column :items, :marked, :boolean
    remove_column :items, :is_marked
  end
end
