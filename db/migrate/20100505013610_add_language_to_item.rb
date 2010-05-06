class AddLanguageToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :language_id, :integer
  end

  def self.down
    remove_column :items, :language_id
  end
end
