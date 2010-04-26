class RemovePaginationLetterFromItems < ActiveRecord::Migration
  def self.up
  remove_column :items, :pagination_letter
  end

  def self.down
    add_column :items, :pagination_letter, :string

  end
end
