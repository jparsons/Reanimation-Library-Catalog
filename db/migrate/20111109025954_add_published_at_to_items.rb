class AddPublishedAtToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :published_at, :datetime
    Item.all.each do |item|
      item.published_at = (Date.today - 1.day)
      item.save
    end
      [ 101247, 101368, 101366, 101365, 101363, 101358, 101350, 101351, 101330, 101336 ].each do |id|
        item = Item.find_by_id(id)
        unless item.nil?
          item.published_at = Date.today
          item.save
        end
      end
  end

  def self.down
    remove_column :items, :published_at
  end
end
