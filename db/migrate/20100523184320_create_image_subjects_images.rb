class CreateImageSubjectsImages < ActiveRecord::Migration[4.2]
  def self.up
    create_table :image_subjects_images, :id=>false do |t|
      t.integer :image_id
      t.integer :image_subject_id
    end
  end

  def self.down
    drop_table :images_image_subjects
  end
end
