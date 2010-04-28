class AddCreatorTypeToCreators < ActiveRecord::Migration
  def self.up
    add_column :creators, :creator_type, :string
  end

  def self.down
    remove_column :creators, :creator_type
  end
end
