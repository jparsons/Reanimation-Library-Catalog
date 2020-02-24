class CreateItemsLanguages < ActiveRecord::Migration[4.2]
  def self.up
    create_table :items_languages, :id => false do |t|
      t.integer :item_id
      t.integer :language_id
    end
  end

  def self.down
    drop_table :items_languages
  end
end
