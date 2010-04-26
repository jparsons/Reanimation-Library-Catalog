class CreateItemsSubjects < ActiveRecord::Migration
  def self.up
    create_table :items_subjects, :id=>false do |t|
      t.integer :item_id
      t.integer :subject_id
    end
  end

  def self.down
    drop_table :items_subjects
  end
end
