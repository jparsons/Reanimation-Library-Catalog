class CreateDonorsItems < ActiveRecord::Migration[4.2]
  def self.up
    create_table :donors_items do |t|
      t.integer :item_id
      t.integer :donor_id
    end    
  end

  def self.down
    drop_table :donors_items
  end
end
