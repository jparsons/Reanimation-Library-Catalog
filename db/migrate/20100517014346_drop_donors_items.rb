class DropDonorsItems < ActiveRecord::Migration
  def self.up
    drop_table :donors_items
  end

  def self.down
  end
end
