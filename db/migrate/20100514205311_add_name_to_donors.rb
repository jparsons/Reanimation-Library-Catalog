class AddNameToDonors < ActiveRecord::Migration
  def self.up
    add_column :donors, :name, :string
  end

  def self.down
    remove_column :donors, :name
  end
end
