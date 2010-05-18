class CreateTableItemsWorks < ActiveRecord::Migration
  def self.up
    create_table :items_works, :id => false do |t|
      t.references :item, :work
    end
    
  end

  def self.down
    drop_table :items_works
  end
end
