class AddMetadataNotesToItems < ActiveRecord::Migration[4.2]
  def self.up
    add_column :items, :metadata_notes, :text
  end

  def self.down
    remove_column :items, :metadata_notes
  end
end
