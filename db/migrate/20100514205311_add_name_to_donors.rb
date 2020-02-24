class AddNameToDonors < ActiveRecord::Migration[4.2]
  def self.up
    add_column :donors, :name, :string
  end

  def self.down
    remove_column :donors, :name
  end
end
