class CreateDonors < ActiveRecord::Migration
  def self.up
    create_table :donors do |t|
      t.string :first_name
      t.string :last_name
      t.string :organization_name
      t.timestamps
    end
  end
  
  def self.down
    drop_table :donors
  end
end
