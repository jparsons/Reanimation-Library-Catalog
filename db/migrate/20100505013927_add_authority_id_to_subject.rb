class AddAuthorityIdToSubject < ActiveRecord::Migration
  def self.up
    add_column :subjects, :authority_id, :integer
  end

  def self.down
    remove_column :subjects, :authority_id
  end
end
