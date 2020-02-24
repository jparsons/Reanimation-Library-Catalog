class CreateImageSubjects < ActiveRecord::Migration[4.2]
  def self.up
    create_table :image_subjects do |t|
      t.string :name
      t.integer :image_subject_authority_id

      t.timestamps
    end
  end

  def self.down
    drop_table :image_subjects
  end
end
