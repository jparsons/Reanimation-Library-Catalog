class AddHasMarcRecordToItems < ActiveRecord::Migration[4.2]
  def self.up
    add_column :items, :has_marc_record, :boolean
  end

  def self.down
    remove_column :items, :has_marc_record
  end
end
