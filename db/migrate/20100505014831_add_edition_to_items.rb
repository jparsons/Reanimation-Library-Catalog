class AddEditionToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :edition, :string
  end

  def self.down
    remove_column :items, :edition
  end
end
