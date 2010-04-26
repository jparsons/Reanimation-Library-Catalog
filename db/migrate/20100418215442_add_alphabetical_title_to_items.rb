class AddAlphabeticalTitleToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :alphabetical_title, :string
  end

  def self.down
    remove_column :items, :alphabetical_title
  end
end
