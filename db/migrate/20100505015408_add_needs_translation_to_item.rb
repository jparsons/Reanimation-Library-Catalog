class AddNeedsTranslationToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :needs_translation, :boolean
  end

  def self.down
    remove_column :items, :needs_translation
  end
end
