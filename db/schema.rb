# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_15_204557) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "creator_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "creators", id: :serial, force: :cascade do |t|
    t.string "first_name", limit: 510
    t.string "last_name", limit: 510
    t.string "middle_name", limit: 510
    t.string "name_suffix", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "item_id"
    t.integer "creator_type_id"
  end

  create_table "delayed_jobs", id: :serial, force: :cascade do |t|
    t.integer "priority", default: 0
    t.integer "attempts", default: 0
    t.text "handler"
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "digital_asset_ingests", id: :serial, force: :cascade do |t|
    t.string "status", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_time"
    t.datetime "end_time"
  end

  create_table "digital_asset_subject_authorities", id: :serial, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name", limit: 510
  end

  create_table "digital_asset_subjects", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "authority", limit: 510
  end

  create_table "digital_asset_subjects_digital_assets", id: false, force: :cascade do |t|
    t.integer "digital_asset_id"
    t.integer "digital_asset_subject_id"
  end

  create_table "digital_assets", id: :serial, force: :cascade do |t|
    t.string "color", limit: 510
    t.string "image_type", limit: 510
    t.string "legacy_id", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "scan_file_name", limit: 510
    t.string "scan_content_type", limit: 510
    t.integer "scan_file_size"
    t.integer "item_id"
    t.boolean "is_marked"
    t.string "page", limit: 510
    t.string "scan"
  end

  create_table "digital_assets_image_types", id: false, force: :cascade do |t|
    t.integer "digital_asset_id"
    t.integer "image_type_id"
  end

  create_table "digital_assets_works", id: false, force: :cascade do |t|
    t.integer "digital_asset_id"
    t.integer "work_id"
  end

  create_table "donors", id: :serial, force: :cascade do |t|
    t.string "organization_name", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name", limit: 510
    t.string "last_name", limit: 510
  end

  create_table "donors_items", id: false, force: :cascade do |t|
    t.integer "donor_id"
    t.integer "item_id"
  end

  create_table "exhibition_venues", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.string "address_line_one", limit: 510
    t.string "address_line_two", limit: 510
    t.string "city", limit: 510
    t.string "state", limit: 510
    t.string "zipcode", limit: 510
    t.string "country", limit: 510
    t.string "phone", limit: 510
    t.string "contact_first_name", limit: 510
    t.string "contact_last_name", limit: 510
    t.string "contact_position", limit: 510
    t.string "contact_email", limit: 510
    t.string "website", limit: 510
    t.string "notes", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exhibitions", id: :serial, force: :cascade do |t|
    t.string "title", limit: 510
    t.date "start_date"
    t.date "end_date"
    t.integer "exhibition_venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exhibitions_works", id: false, force: :cascade do |t|
    t.integer "exhibition_id"
    t.integer "work_id"
  end

  create_table "image_colors", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "image_colors_items", id: false, force: :cascade do |t|
    t.integer "image_color_id"
    t.integer "item_id"
  end

  create_table "image_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "image_types_items", id: false, force: :cascade do |t|
    t.integer "image_type_id"
    t.integer "item_id"
  end

  create_table "items", id: :serial, force: :cascade do |t|
    t.string "title", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "alphabetical_title", limit: 510
    t.string "subtitle", limit: 510
    t.string "publisher_name", limit: 510
    t.string "publisher_city", limit: 510
    t.string "publisher_state", limit: 510
    t.string "publisher_country", limit: 510
    t.string "extent", limit: 510
    t.string "copyright", limit: 510
    t.string "item_size", limit: 510
    t.string "call_number", limit: 510
    t.string "collection_name", limit: 510
    t.integer "legacy_id"
    t.string "cover_image_file_name", limit: 510
    t.string "cover_image_content_type", limit: 510
    t.integer "cover_image_image_file_size"
    t.datetime "cover_image_updated_at"
    t.string "barcode", limit: 510
    t.boolean "has_marc_record"
    t.text "metadata_notes"
    t.string "corporate_author", limit: 510
    t.string "isbn_issn", limit: 510
    t.boolean "is_government_document"
    t.string "edition", limit: 510
    t.text "notes"
    t.string "series_name", limit: 510
    t.boolean "needs_translation"
    t.string "location", limit: 510
    t.boolean "is_marked"
    t.integer "vendor_id"
    t.date "date_acquired"
    t.decimal "price_paid", precision: 8, scale: 2
    t.string "acquisition_type", limit: 510
    t.text "acquisition_note"
    t.string "acquired_for", limit: 510
    t.integer "legacy_record_id"
    t.string "cataloging_status", limit: 510
    t.string "provenance", limit: 510
    t.text "dedication"
    t.string "physical_format", limit: 510
    t.datetime "published_at"
    t.text "inscription"
    t.string "cover_image"
  end

  create_table "items2", id: :serial, force: :cascade do |t|
    t.string "title", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "alphabetical_title", limit: 510
    t.string "subtitle", limit: 510
    t.string "publisher_name", limit: 510
    t.string "publisher_city", limit: 510
    t.string "publisher_state", limit: 510
    t.string "publisher_country", limit: 510
    t.string "extent", limit: 510
    t.string "copyright", limit: 510
    t.string "item_size", limit: 510
    t.string "call_number", limit: 510
    t.string "collection_name", limit: 510
    t.integer "legacy_id"
    t.string "cover_image_file_name", limit: 510
    t.string "cover_image_content_type", limit: 510
    t.integer "cover_image_image_file_size"
    t.datetime "cover_image_updated_at"
    t.string "barcode", limit: 510
    t.boolean "has_marc_record"
    t.text "metadata_notes"
    t.string "corporate_author", limit: 510
    t.string "isbn_issn", limit: 510
    t.boolean "is_government_document"
    t.string "edition", limit: 510
    t.text "notes"
    t.string "series_name", limit: 510
    t.boolean "needs_translation"
    t.string "location", limit: 510
    t.boolean "is_marked"
    t.integer "vendor_id"
    t.date "date_acquired"
    t.decimal "price_paid", precision: 8, scale: 2
    t.string "acquisition_type", limit: 510
    t.text "acquisition_note"
    t.string "acquired_for", limit: 510
    t.integer "legacy_record_id"
    t.string "cataloging_status", limit: 510
    t.string "provenance", limit: 510
    t.text "dedication"
    t.string "physical_format", limit: 510
    t.datetime "published_at"
  end

  create_table "items_languages", id: false, force: :cascade do |t|
    t.integer "item_id"
    t.integer "language_id"
  end

  create_table "items_subjects", id: false, force: :cascade do |t|
    t.integer "item_id"
    t.integer "subject_id"
  end

  create_table "items_works", id: false, force: :cascade do |t|
    t.integer "item_id"
    t.integer "work_id"
  end

  create_table "languages", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "log_entries", id: :serial, force: :cascade do |t|
    t.integer "process_log_id"
    t.text "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "process_logs", id: :serial, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "digital_asset_ingest_id"
  end

  create_table "series", id: :serial, force: :cascade do |t|
    t.string "title", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "series_parts", id: :serial, force: :cascade do |t|
    t.integer "item_id"
    t.integer "series_id"
    t.integer "position"
    t.string "volume_identifier", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subject_authorities", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "authority", limit: 510
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type", limit: 510
    t.integer "tagger_id"
    t.string "tagger_type", limit: 510
    t.string "context", limit: 256
    t.datetime "created_at"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username", limit: 510
    t.string "email", limit: 510
    t.string "persistence_token", limit: 510
    t.string "encrypted_password", limit: 510
    t.string "password_salt", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "role", limit: 510
    t.string "confirmation_token", limit: 510
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email", limit: 510
    t.string "reset_password_token", limit: 510
    t.datetime "reset_password_sent_at"
    t.string "remember_token", limit: 510
    t.datetime "remember_created_at"
    t.string "unlock_token", limit: 510
    t.datetime "locked_at"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 510
    t.string "last_sign_in_ip", limit: 510
    t.integer "failed_attempts"
    t.integer "sign_in_count"
    t.index ["confirmation_token"], name: "users_confirmation_token_key", unique: true
    t.index ["reset_password_token"], name: "users_reset_password_token_key", unique: true
    t.index ["unlock_token"], name: "users_unlock_token_key", unique: true
  end

  create_table "vendors", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.string "street", limit: 510
    t.string "city", limit: 510
    t.string "state", limit: 510
    t.string "zip", limit: 510
    t.string "country", limit: 510
    t.string "url", limit: 510
    t.string "phone", limit: 510
    t.string "notes", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "legacy_id"
  end

  create_table "work_creators", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "work_creators_works", id: false, force: :cascade do |t|
    t.integer "work_id"
    t.integer "work_creator_id"
  end

  create_table "work_images", id: :serial, force: :cascade do |t|
    t.integer "work_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "image_file_name", limit: 510
    t.string "image_content_type", limit: 510
    t.integer "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "works", id: :serial, force: :cascade do |t|
    t.string "title", limit: 510
    t.string "medium", limit: 510
    t.string "size", limit: 510
    t.integer "year_created"
    t.string "work_type", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "creator_id"
    t.integer "legacy_id"
    t.string "textfile_file_name", limit: 510
    t.string "textfile_content_type", limit: 510
    t.integer "textfile_file_size"
    t.datetime "textfile_updated_at"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
