class AddPageToDigitalAssets < ActiveRecord::Migration
  def self.up
    add_column :digital_assets, :page, :string
  end

  def self.down
    remove_column :digital_assets, :page
  end
end
