class ChangeGenreToWorkTypeInWorks < ActiveRecord::Migration[4.2]
  def self.up
    rename_column :works, :genre, :work_type
  end

  def self.down
    rename_column :works, :work_type, :genre
  end
end
