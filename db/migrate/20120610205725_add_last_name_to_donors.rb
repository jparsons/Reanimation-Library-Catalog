class AddLastNameToDonors < ActiveRecord::Migration
  def self.up
    add_column :donors, :last_name, :string
    Donor.all.each do |d|
      d.save
    end
  end

  def self.down
    remove_column :donors, :last_name
  end
end
