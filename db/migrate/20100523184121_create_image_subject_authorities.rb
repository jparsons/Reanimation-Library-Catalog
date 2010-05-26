class CreateImageSubjectAuthorities < ActiveRecord::Migration
  def self.up
    create_table :image_subject_authorities do |t|
      t.name :string

      t.timestamps
    end
  end

  def self.down
    drop_table :image_subject_authorities
  end
end
