class AddAuthorityToSubject < ActiveRecord::Migration
  def self.up
    add_column :subjects, :authority, :string
  end

  def self.down
    remove_column :subjects, :authority
  end
end
