class RecreateDonorsItems < ActiveRecord::Migration
  def self.up
    create_table :donors_items, :id => false do |t|
      t.references :donor, :item
    end
    
  end

  def self.down
    drop_table :donors_items
  end
end
