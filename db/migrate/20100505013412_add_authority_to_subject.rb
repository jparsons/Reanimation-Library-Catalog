class AddAuthorityToSubject < ActiveRecord::Migration[4.2]
  def self.up
    add_column :subjects, :authority, :string
  end

  def self.down
    remove_column :subjects, :authority
  end
end
