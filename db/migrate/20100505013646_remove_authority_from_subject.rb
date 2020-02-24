class RemoveAuthorityFromSubject < ActiveRecord::Migration[4.2]
  def self.up
    remove_column :subjects, :authority 
  end

  def self.down
    add_column :subjects, :authority, :string
  end
end
