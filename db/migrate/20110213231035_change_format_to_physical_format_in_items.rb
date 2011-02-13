class ChangeFormatToPhysicalFormatInItems < ActiveRecord::Migration
  def self.up
    rename_column :items, :format, :physical_format
  end

  def self.down
  end
end
