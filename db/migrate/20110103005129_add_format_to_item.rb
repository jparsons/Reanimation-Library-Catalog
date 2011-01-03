class AddFormatToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :format, :string
  end

  def self.down
    remove_column :items, :format
  end
end
