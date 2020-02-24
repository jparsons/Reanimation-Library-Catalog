class ChangeAuthorityIdToSubjectAuthorityIdInSubjects < ActiveRecord::Migration[4.2]
  def self.up
    remove_column :subjects, :authority_id
    add_column :subjects, :subject_authority_id, :integer
  end

  def self.down
    add_column :subjects, :authority_id, :integer
    remove_column :subjects, :subject_authority_id
  end
end
