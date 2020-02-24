class CreateCreators < ActiveRecord::Migration[4.2]
  def self.up
    create_table :creators do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :name_suffix

      t.timestamps
    end
  end

  def self.down
    drop_table :creators
  end
end
