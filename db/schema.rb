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

ActiveRecord::Schema.define(:version => 20101221234755) do

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

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "digital_asset_ingests", :force => true do |t|
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_time"
    t.datetime "end_time"
  end

  create_table "digital_asset_subject_authorities", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "digital_asset_subjects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authority"
  end

  create_table "digital_asset_subjects_digital_assets", :id => false, :force => true do |t|
    t.integer "digital_asset_id"
    t.integer "digital_asset_subject_id"
  end

  create_table "digital_assets", :force => true do |t|
    t.string   "color"
    t.string   "image_type"
    t.string   "legacy_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "scan_file_name"
    t.string   "scan_content_type"
    t.integer  "scan_file_size"
    t.integer  "item_id"
    t.boolean  "is_marked"
    t.string   "page"
  end

  create_table "donors", :force => true do |t|
    t.string   "organization_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "donors_items", :id => false, :force => true do |t|
    t.integer "donor_id"
    t.integer "item_id"
  end

  create_table "exhibition_venues", :force => true do |t|
    t.string   "name"
    t.string   "address_line_one"
    t.string   "address_line_two"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "country"
    t.string   "phone"
    t.string   "contact_first_name"
    t.string   "contact_last_name"
    t.string   "contact_position"
    t.string   "contact_email"
    t.string   "website"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exhibitions", :force => true do |t|
    t.string   "title"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "exhibition_venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exhibitions_works", :force => true do |t|
    t.integer "exhibition_id"
    t.integer "work_id"
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
    t.integer  "vendor_id"
    t.date     "date_acquired"
    t.decimal  "price_paid"
    t.string   "acquisition_type"
    t.text     "acquisition_note"
    t.string   "acquired_for"
    t.integer  "legacy_record_id"
    t.string   "cataloging_status"
    t.string   "provenance"
    t.text     "dedication"
    t.string   "language"
  end

  create_table "items_subjects", :id => false, :force => true do |t|
    t.integer "item_id"
    t.integer "subject_id"
  end

  create_table "items_works", :id => false, :force => true do |t|
    t.integer "item_id"
    t.integer "work_id"
  end

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "log_entries", :force => true do |t|
    t.integer  "process_log_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "process_logs", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "digital_asset_ingest_id"
  end

  create_table "series", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "series_parts", :force => true do |t|
    t.integer  "item_id"
    t.integer  "series_id"
    t.integer  "position"
    t.string   "volume_identifier"
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
    t.string   "authority"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "persistence_token"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
  end

  create_table "vendors", :force => true do |t|
    t.string   "name"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.string   "url"
    t.string   "phone"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "legacy_id"
  end

  create_table "work_creators", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "work_creators_works", :id => false, :force => true do |t|
    t.integer "work_id"
    t.integer "work_creator_id"
  end

  create_table "work_images", :force => true do |t|
    t.integer  "work_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "works", :force => true do |t|
    t.string   "title"
    t.string   "medium"
    t.string   "size"
    t.integer  "year_created"
    t.string   "work_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "legacy_id"
    t.string   "textfile_file_name"
    t.string   "textfile_content_type"
    t.integer  "textfile_file_size"
    t.datetime "textfile_updated_at"
  end

end
