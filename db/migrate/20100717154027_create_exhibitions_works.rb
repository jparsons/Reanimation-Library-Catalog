class CreateExhibitionsWorks < ActiveRecord::Migration
  def self.up
    create_table :exhibitions_works do |t|
      t.integer :exhibition_id
      t.integer :work_id
      
    end
  end

  def self.down
    drop_table :exhibition_works
  end
end
