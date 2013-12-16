class ChangePricePaid < ActiveRecord::Migration
  def self.up
    change_column :items, :price_paid, :decimal, :precision => 8, :scale =>     2
  end

  def self.down
  end
end
