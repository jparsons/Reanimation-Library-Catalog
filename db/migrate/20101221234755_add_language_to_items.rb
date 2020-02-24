class AddLanguageToItems < ActiveRecord::Migration[4.2]
  def self.up
    add_column :items, :language, :string
  end

  def self.down
    remove_column :items, :language
  end
end
