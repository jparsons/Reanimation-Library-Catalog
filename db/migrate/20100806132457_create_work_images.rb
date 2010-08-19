class CreateWorkImages < ActiveRecord::Migration
  def self.up
    create_table :work_images do |t|
      t.integer :work_id
      t.image_file_name :string
      t.image_content_type :string
      t.image_file_size :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :work_images
  end
end
