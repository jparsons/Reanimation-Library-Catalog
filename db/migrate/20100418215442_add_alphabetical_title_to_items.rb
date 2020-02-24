class AddAlphabeticalTitleToItems < ActiveRecord::Migration[4.2]
  def self.up
    add_column :items, :alphabetical_title, :string
  end

  def self.down
    remove_column :items, :alphabetical_title
  end
end
