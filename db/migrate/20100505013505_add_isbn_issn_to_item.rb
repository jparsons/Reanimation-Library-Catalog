class AddIsbnIssnToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :isbn_issn, :string
  end

  def self.down
    remove_column :items, :isbn_issn
  end
end
