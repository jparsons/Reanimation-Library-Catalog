class AddDedicationToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :dedication, :text
  end

  def self.down
    remove_column :items, :dedication
  end
end
