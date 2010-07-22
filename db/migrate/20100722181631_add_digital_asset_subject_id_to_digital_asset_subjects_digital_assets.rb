class AddDigitalAssetSubjectIdToDigitalAssetSubjectsDigitalAssets < ActiveRecord::Migration
  def self.up
    add_column :digital_asset_subjects_digital_assets, :digital_asset_subject_id, :integer
  end

  def self.down
    remove_column :digital_asset_subjects_digital_assets, :digital_asset_subject_id
  end
end
