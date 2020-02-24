class AddCreatorTypeToCreators < ActiveRecord::Migration[4.2]
  def self.up
    add_column :creators, :creator_type, :string
  end

  def self.down
    remove_column :creators, :creator_type
  end
end
