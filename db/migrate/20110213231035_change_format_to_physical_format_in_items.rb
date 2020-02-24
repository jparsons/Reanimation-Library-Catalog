class ChangeFormatToPhysicalFormatInItems < ActiveRecord::Migration[4.2]
  def self.up
    rename_column :items, :format, :physical_format
  end

  def self.down
  end
end
