class AddAuthorityToDigitalAssetSubjects < ActiveRecord::Migration
  def self.up
    add_column :digital_asset_subjects, :authority, :string
  end

  def self.down
    remove_column :digital_asset_subjects, :authority
  end
end
