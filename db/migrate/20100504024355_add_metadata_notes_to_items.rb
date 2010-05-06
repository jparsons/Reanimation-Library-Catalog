class AddMetadataNotesToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :metadata_notes, :text
  end

  def self.down
    remove_column :items, :metadata_notes
  end
end
