class RemoveAuthorityFromSubject < ActiveRecord::Migration
  def self.up
    remove_column :subjects, :authority 
  end

  def self.down
    add_column :subjects, :authority, :string
  end
end
