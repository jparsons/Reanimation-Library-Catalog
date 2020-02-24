class AddPageToDigitalAssets < ActiveRecord::Migration[4.2]
  def self.up
    add_column :digital_assets, :page, :string
  end

  def self.down
    remove_column :digital_assets, :page
  end
end
