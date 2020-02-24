class CreateSeries < ActiveRecord::Migration[4.2]
  def self.up
    create_table :series do |t|
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :series
  end
end
