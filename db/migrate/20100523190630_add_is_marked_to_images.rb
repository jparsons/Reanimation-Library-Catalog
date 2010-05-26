class AddIsMarkedToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :is_marked, :boolean
  end

  def self.down
    remove_column :images, :is_marked
  end
end
