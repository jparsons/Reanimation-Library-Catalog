class MoveCreatorTypesOffCreator < ActiveRecord::Migration
  def self.up
  	# add_column :creators, :creator_type_id, :integer
  	# Creator.all.each do |creator|
  	#   creator_type = CreatorType.where(:name=>creator[:creator_type]).first
  	#   creator.creator_type = creator_type if creator_type
  	#   creator.save
  	# end
  	# remove_column :creators, :creator_type
  end

  def self.down
  	remove_column :creators, :creator_type_id
  end
end
