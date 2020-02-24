class DropImageSubjectIdFromDigitalAssetSubjectsDigitalAssets < ActiveRecord::Migration[4.2]
  def self.up
    remove_column :digital_asset_subjects_digital_assets, :image_subject_id 
  end

  def self.down
    add_column :digital_asset_subjects_digital_assets, :image_subject_id, :integer
  end
end
