class DropSubjectAuthorityIdFromSubjects < ActiveRecord::Migration[4.2]
  def self.up
    remove_column :subjects, :subject_authority_id
  end

  def self.down
    add_column :sujects, :subject_authority_id, :integer
  end
end
