class ChangeGenreToWorkTypeInWorks < ActiveRecord::Migration
  def self.up
    rename_column :works, :genre, :work_type
  end

  def self.down
    rename_column :works, :work_type, :genre
  end
end
