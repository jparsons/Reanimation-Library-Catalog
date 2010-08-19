class CreateWorkCreatorsWorks < ActiveRecord::Migration
  def self.up
    create_table :work_creators_works, :id => false do |t|
      t.references :work, :work_creator
    end
    
  end

  def self.down
    drop_table :work_creators_works
  end
end
