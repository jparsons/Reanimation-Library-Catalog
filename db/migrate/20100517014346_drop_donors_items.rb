class DropDonorsItems < ActiveRecord::Migration[4.2]
  def self.up
    drop_table :donors_items
  end

  def self.down
  end
end
