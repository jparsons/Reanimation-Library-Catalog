class CreateWorkCreators < ActiveRecord::Migration[4.2]
  def self.up
    create_table :work_creators do |t|
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end

  def self.down
    drop_table :work_creators
  end
end
