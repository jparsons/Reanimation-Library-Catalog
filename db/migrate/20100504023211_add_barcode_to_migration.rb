class AddBarcodeToMigration < ActiveRecord::Migration[4.2]
  def self.up
    add_column :items, :barcode, :string
  end

  def self.down
    remove_column :items, :barcode
  end
end
