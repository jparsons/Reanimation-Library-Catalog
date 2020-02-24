class AddRolesToUser < ActiveRecord::Migration[4.2]
  def self.up
    add_column :users, :roles, :string, :default=> "--- []"
  end

  def self.down
    remove_column :users, :roles
  end
end
