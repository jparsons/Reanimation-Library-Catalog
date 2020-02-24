class MakeFirstNameAndLastNameIntoNameInWorkCreators < ActiveRecord::Migration[4.2]
  def self.up
    remove_column :work_creators, :last_name
    rename_column :work_creators, :first_name, :name
  end

  def self.down
    add_column :work_creators, :last_name, :string
    rename_column :work_creators, :name, :first_name
  end
end
