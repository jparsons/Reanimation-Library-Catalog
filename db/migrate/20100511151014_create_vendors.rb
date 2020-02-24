class CreateVendors < ActiveRecord::Migration[4.2]
  def self.up
    create_table :vendors do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.string :url
      t.string :phone
      t.string :notes
      t.timestamps
    end
  end
  
  def self.down
    drop_table :vendors
  end
end
