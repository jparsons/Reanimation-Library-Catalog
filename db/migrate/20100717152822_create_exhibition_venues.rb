class CreateExhibitionVenues < ActiveRecord::Migration
  def self.up
    create_table :exhibition_venues do |t|
      t.string :name
      t.string :address_line_one
      t.string :address_line_two
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :country
      t.string :phone
      t.string :contact_first_name
      t.string :contact_last_name
      t.string :contact_position
      t.string :contact_email
      t.string :website
      t.string :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :exhibition_venues
  end
end
