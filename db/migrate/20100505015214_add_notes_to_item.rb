class AddNotesToItem < ActiveRecord::Migration[4.2]
  def self.up
    add_column :items, :notes, :text
  end

  def self.down
    remove_column :items, :notes
  end
end
