class RemoveFirstNameAndLastNameFromDonors < ActiveRecord::Migration
  def self.up
    remove_column :donors, :first_name
    remove_column :donors, :last_name
  end

  def self.down
    add_column :donors, :first_name, :string
    add_column :donors, :last_name, :string
  end
end
