class CreateItems < ActiveRecord::Migration[4.2]
  def self.up
    create_table :items do |t|
      t.string :title
      t.timestamps
    end
  end
  
  def self.down
    drop_table :items
  end
end
