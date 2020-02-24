class AddIsbnIssnToItem < ActiveRecord::Migration[4.2]
  def self.up
    add_column :items, :isbn_issn, :string
  end

  def self.down
    remove_column :items, :isbn_issn
  end
end
