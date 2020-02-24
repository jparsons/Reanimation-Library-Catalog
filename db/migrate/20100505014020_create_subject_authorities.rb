class CreateSubjectAuthorities < ActiveRecord::Migration[4.2]
  def self.up
    create_table :subject_authorities do |t|
      t.string :name
      t.timestamps
    end
  end
  
  def self.down
    drop_table :subject_authorities
  end
end
