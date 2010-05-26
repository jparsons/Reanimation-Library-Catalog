class Image < ActiveRecord::Migration
  def self.up
    create_table :images, :force=>true do |t|
      t.integer :item_id
      t.color :string
      t.image_type :string
      t.is_marked :boolean
      t.image_file_name :string
      t.image_content_type :string
      t.image_file_size :integer
      t.image_update_at :datetime
    end
  end

  def self.down
    drop_table :images
  end
end
