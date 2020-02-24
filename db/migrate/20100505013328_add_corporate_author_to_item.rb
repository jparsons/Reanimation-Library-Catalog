class AddCorporateAuthorToItem < ActiveRecord::Migration[4.2]
  def self.up
    add_column :items, :corporate_author, :string
  end

  def self.down
    remove_column :items, :corporate_author
  end
end
