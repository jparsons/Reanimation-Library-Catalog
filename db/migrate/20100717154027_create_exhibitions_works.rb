class CreateExhibitionsWorks < ActiveRecord::Migration[4.2]
  def self.up
    create_table :exhibitions_works, :id=>false do |t|
      t.integer :exhibition_id
      t.integer :work_id
      
    end
  end

  def self.down
    drop_table :exhibition_works
  end
end
