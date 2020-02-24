class ChangePricePaid < ActiveRecord::Migration[4.2]
  def self.up
    change_column :items, :price_paid, :decimal, :precision => 8, :scale =>     2
  end

  def self.down
  end
end
