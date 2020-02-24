class ChangeCollectionNames < ActiveRecord::Migration[4.2]
  def self.up

  	Item.all.each do |i|
      i.update_attribute(:collection_name, i.collection_name.gsub(/^[123]: /, "").gsub(/^1A: /, "").gsub(/^1A: /, ""))
  	end
  end
end
