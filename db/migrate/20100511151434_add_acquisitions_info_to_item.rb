class AddAcquisitionsInfoToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :vendor_id, :integer
    add_column :items, :date_acquired, :date
    add_column :items, :price_paid, :decimal, :precision => 8, :scale => 2
    add_column :items, :acquisition_type, :string
    add_column :items, :gift_type, :string
    add_column :items, :acquisition_note, :text
    add_column :items, :acquired_for, :string
  end

  def self.down
    remove_column :items, :acquired_for
    remove_column :items, :acquisition_note
    remove_column :items, :gift_type
    remove_column :items, :acquisition_type
    remove_column :items, :price_paid
    remove_column :items, :date_acquired
    remove_column :items, :vendor_id
  end
end
