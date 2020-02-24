class AddCreatorIdToWorks < ActiveRecord::Migration[4.2]
  def self.up
    add_column :works, :creator_id, :integer
  end

  def self.down
    remove_column :works, :creator_id
  end
end
