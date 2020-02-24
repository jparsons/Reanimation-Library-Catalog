class GatherCreatorTypesFromCreators < ActiveRecord::Migration[4.2]
  def self.up
  	creator_types = Creator.all.map(&:old_creator_type).uniq
  	creator_types.each do |creator_type|
  		CreatorType.create(:name => creator_type) unless creator_type.blank?
  	end
  end

  def self.down
  end
end
