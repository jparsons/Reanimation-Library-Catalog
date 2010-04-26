class AddBasicFieldsToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :subtitle, :string
    add_column :items, :publisher_name, :string
    add_column :items, :publisher_city, :string
    add_column :items, :publisher_state, :string
    add_column :items, :publisher_country, :string
    add_column :items, :extent, :string
    add_column :items, :copyright, :string
    add_column :items, :item_size, :string
    add_column :items, :call_number, :string
    add_column :items, :collection_name, :string
    add_column :items, :legacy_id, :integer
  end

  def self.down
    remove_column :items, :legacy_id
    remove_column :items, :collection_name
    remove_column :items, :call_number
    remove_column :items, :item_size
    remove_column :items, :copyright
    remove_column :items, :extent
    remove_column :items, :publisher_country
    remove_column :items, :publisher_state
    remove_column :items, :publisher_city
    remove_column :items, :publisher_name
    remove_column :items, :subtitle
  end
end
