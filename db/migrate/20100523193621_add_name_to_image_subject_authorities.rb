class AddNameToImageSubjectAuthorities < ActiveRecord::Migration
  def self.up
    add_column :image_subject_authorities, :name, :string
  end

  def self.down
    remove_column :image_subject_authorities, :name
  end
end
