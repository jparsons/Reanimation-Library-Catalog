class AddScanToImages < ActiveRecord::Migration[4.2]
    def self.up
      add_column :images, :scan_file_name, :string
      add_column :images, :scan_content_type, :string
      add_column :images, :scan_file_size, :integer
    end

    def self.down
      remove_column :images, :scan_file_name
      remove_column :images, :scan_content_type
      remove_column :images, :scan_file_size
    end
  end