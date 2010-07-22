class RemoveDigitalAssetSubjectAuthorityIdFromDigitalAssetSubjects < ActiveRecord::Migration
  def self.up
    remove_column :digital_asset_subjects, :digital_asset_subject_authority_id
  end

  def self.down
    add_column :digital_asset_subjects, :digital_asset_subject_authority_id, :integer
  end
end
