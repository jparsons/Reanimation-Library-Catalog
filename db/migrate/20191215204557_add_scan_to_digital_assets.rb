class AddScanToDigitalAssets < ActiveRecord::Migration[5.2]
  def change
    add_column :digital_assets, :scan, :string
  end
end
