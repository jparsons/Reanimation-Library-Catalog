class AddLocationToItems < ActiveRecord::Migration[4.2]
  def self.up
    add_column :items, :location, :string
  end

  def self.down
    remove_column :items, :location
  end
end
