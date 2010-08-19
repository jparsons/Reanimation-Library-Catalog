class AddCreatorIdToWorks < ActiveRecord::Migration
  def self.up
    add_column :works, :creator_id, :integer
  end

  def self.down
    remove_column :works, :creator_id
  end
end
