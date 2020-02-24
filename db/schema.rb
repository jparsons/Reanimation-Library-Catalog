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
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "creators", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "middle_name"
    t.string "name_suffix"
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
    t.string "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "digital_asset_ingests", id: :serial, force: :cascade do |t|
    t.string "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_time"
    t.datetime "end_time"
  end

  create_table "digital_asset_subject_authorities", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "digital_asset_subjects", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "authority"
  end

  create_table "digital_asset_subjects_digital_assets", id: false, force: :cascade do |t|
    t.integer "digital_asset_id"
    t.integer "digital_asset_subject_id"
  end

  create_table "digital_assets", id: :serial, force: :cascade do |t|
    t.integer "item_id"
    t.string "color"
    t.string "image_type"
    t.string "legacy_id"
    t.boolean "is_marked"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "scan_file_name"
    t.string "scan_content_type"
    t.integer "scan_file_size"
    t.string "page"
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
    t.string "organization_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name"
    t.string "last_name"
  end

  create_table "donors_items", id: false, force: :cascade do |t|
    t.integer "donor_id"
    t.integer "item_id"
  end

  create_table "exhibition_venues", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "address_line_one"
    t.string "address_line_two"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.string "country"
    t.string "phone"
    t.string "contact_first_name"
    t.string "contact_last_name"
    t.string "contact_position"
    t.string "contact_email"
    t.string "website"
    t.string "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exhibitions", id: :serial, force: :cascade do |t|
    t.string "title"
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
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "image_colors_items", id: false, force: :cascade do |t|
    t.integer "image_color_id"
    t.integer "item_id"
  end

  create_table "image_types", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "image_types_items", id: false, force: :cascade do |t|
    t.integer "image_type_id"
    t.integer "item_id"
  end

  create_table "items", id: :serial, force: :cascade do |t|
    t.string "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "alphabetical_title"
    t.string "subtitle"
    t.string "publisher_name"
    t.string "publisher_city"
    t.string "publisher_state"
    t.string "publisher_country"
    t.string "extent"
    t.string "copyright"
    t.string "item_size"
    t.string "call_number"
    t.string "collection_name"
    t.integer "legacy_id"
    t.string "cover_image_file_name"
    t.string "cover_image_content_type"
    t.integer "cover_image_file_size"
    t.datetime "cover_image_updated_at"
    t.string "barcode"
    t.boolean "has_marc_record"
    t.text "metadata_notes"
    t.string "corporate_author"
    t.string "isbn_issn"
    t.boolean "is_government_document"
    t.string "edition"
    t.text "notes"
    t.string "series_name"
    t.boolean "needs_translation"
    t.string "location"
    t.boolean "is_marked"
    t.integer "vendor_id"
    t.date "date_acquired"
    t.decimal "price_paid", precision: 8, scale: 2
    t.string "acquisition_type"
    t.text "acquisition_note"
    t.string "acquired_for"
    t.integer "legacy_record_id"
    t.string "cataloging_status"
    t.string "provenance"
    t.text "dedication"
    t.string "physical_format"
    t.datetime "published_at"
    t.text "inscription"
    t.string "cover_image"
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
    t.string "name"
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
    t.string "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "series_parts", id: :serial, force: :cascade do |t|
    t.integer "item_id"
    t.integer "series_id"
    t.integer "position"
    t.string "volume_identifier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subject_authorities", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "authority"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "persistence_token"
    t.string "encrypted_password"
    t.string "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "role"
    t.string "confirmation_token", limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.string "remember_token", limit: 255
    t.datetime "remember_created_at"
    t.string "unlock_token", limit: 255
    t.datetime "locked_at"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts"
    t.integer "sign_in_count"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "vendors", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "country"
    t.string "url"
    t.string "phone"
    t.string "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "legacy_id"
  end

  create_table "work_creators", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "work_creators_works", id: false, force: :cascade do |t|
    t.integer "work_id"
    t.integer "work_creator_id"
  end

  create_table "work_images", force: :cascade do |t|
    t.integer "work_id"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "works", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "medium"
    t.string "size"
    t.integer "year_created"
    t.string "work_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "creator_id"
    t.integer "legacy_id"
    t.string "textfile_file_name"
    t.string "textfile_content_type"
    t.integer "textfile_file_size"
    t.datetime "textfile_updated_at"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
