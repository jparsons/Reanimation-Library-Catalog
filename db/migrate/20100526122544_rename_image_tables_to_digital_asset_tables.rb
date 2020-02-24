class RenameImageTablesToDigitalAssetTables < ActiveRecord::Migration[4.2]
  def self.up
    rename_table :images, :digital_assets
    rename_table :image_subjects, :digital_asset_subjects
    rename_table :image_subject_authorities, :digital_asset_subject_authorities
    rename_table :image_subjects_images, :digital_asset_subjects_digital_assets
    rename_column :digital_asset_subjects_digital_assets, :image_id, :digital_asset_id
    rename_column :digital_asset_subjects, :image_subject_authority_id, :digital_asset_subject_authority_id
    
  end

  def self.down
  end
end
