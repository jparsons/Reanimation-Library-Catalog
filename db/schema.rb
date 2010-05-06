# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100505021158) do

  create_table "creators", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "name_suffix"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "creator_type"
    t.integer  "item_id"
  end

  create_table "items", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "alphabetical_title"
    t.string   "subtitle"
    t.string   "publisher_name"
    t.string   "publisher_city"
    t.string   "publisher_state"
    t.string   "publisher_country"
    t.string   "extent"
    t.string   "copyright"
    t.string   "item_size"
    t.string   "call_number"
    t.string   "collection_name"
    t.integer  "legacy_id"
    t.string   "cover_image_file_name"
    t.string   "cover_image_content_type"
    t.integer  "cover_image_image_file_size"
    t.datetime "cover_image_updated_at"
    t.string   "barcode"
    t.boolean  "has_marc_record"
    t.text     "metadata_notes"
    t.string   "corporate_author"
    t.string   "isbn_issn"
    t.integer  "language_id"
    t.boolean  "is_government_document"
    t.string   "edition"
    t.text     "notes"
    t.string   "series_name"
    t.boolean  "needs_translation"
    t.string   "location"
    t.boolean  "is_marked"
  end

  create_table "items_subjects", :id => false, :force => true do |t|
    t.integer "item_id"
    t.integer "subject_id"
  end

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subject_authorities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subject_authority_id"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "persistence_token"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "roles",             :default => "--- []"
  end

end
