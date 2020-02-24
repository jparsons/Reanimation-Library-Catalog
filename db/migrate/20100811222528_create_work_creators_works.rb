class CreateWorkCreatorsWorks < ActiveRecord::Migration[4.2]
  def self.up
    create_table :work_creators_works, :id => false do |t|
      t.references :work, :work_creator
    end
    
  end

  def self.down
    drop_table :work_creators_works
  end
end
