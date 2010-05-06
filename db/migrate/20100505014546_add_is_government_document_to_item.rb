class AddIsGovernmentDocumentToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :is_government_document, :boolean
  end

  def self.down
    remove_column :items, :is_government_document
  end
end
