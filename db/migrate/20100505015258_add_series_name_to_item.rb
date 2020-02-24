class AddSeriesNameToItem < ActiveRecord::Migration[4.2]
  def self.up
    add_column :items, :series_name, :string
  end

  def self.down
    remove_column :items, :series_name
  end
end
