class AddCorporateAuthorToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :corporate_author, :string
  end

  def self.down
    remove_column :items, :corporate_author
  end
end
