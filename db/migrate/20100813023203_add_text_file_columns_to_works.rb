class AddTextFileColumnsToWorks < ActiveRecord::Migration[4.2]
  def self.up
    add_column :works, :textfile_file_name, :string
    add_column :works, :textfile_content_type, :string
    add_column :works, :textfile_file_size, :integer
    add_column :works, :textfile_updated_at, :datetime
  end

  def self.down
    remove_column :works, :textfile_updated_at
    remove_column :works, :textfile_file_size
    remove_column :works, :textfile_content_type
    remove_column :works, :textfile_file_name
  end
end
