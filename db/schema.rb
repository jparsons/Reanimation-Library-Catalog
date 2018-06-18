# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20180618192652) do

  create_table "creator_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "creators", force: :cascade do |t|
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "middle_name",     limit: 255
    t.string   "name_suffix",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_id",         limit: 4
    t.integer  "creator_type_id", limit: 4
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0
    t.integer  "attempts",   limit: 4,     default: 0
    t.text     "handler",    limit: 65535
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "digital_asset_ingests", force: :cascade do |t|
    t.string   "status",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_time"
    t.datetime "end_time"
  end

  create_table "digital_asset_subject_authorities", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",       limit: 255
  end

  create_table "digital_asset_subjects", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authority",  limit: 255
  end

  create_table "digital_asset_subjects_digital_assets", id: false, force: :cascade do |t|
    t.integer "digital_asset_id",         limit: 4
    t.integer "digital_asset_subject_id", limit: 4
  end

  create_table "digital_assets", force: :cascade do |t|
    t.string   "color",             limit: 255
    t.string   "image_type",        limit: 255
    t.string   "legacy_id",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "scan_file_name",    limit: 255
    t.string   "scan_content_type", limit: 255
    t.integer  "scan_file_size",    limit: 4
    t.integer  "item_id",           limit: 4
    t.boolean  "is_marked",         limit: 1
    t.string   "page",              limit: 255
  end

  create_table "digital_assets_image_types", id: false, force: :cascade do |t|
    t.integer "digital_asset_id", limit: 4
    t.integer "image_type_id",    limit: 4
  end

  create_table "digital_assets_works", id: false, force: :cascade do |t|
    t.integer "digital_asset_id", limit: 4
    t.integer "work_id",          limit: 4
  end

  create_table "donors", force: :cascade do |t|
    t.string   "organization_name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",              limit: 255
    t.string   "last_name",         limit: 255
  end

  create_table "donors_items", id: false, force: :cascade do |t|
    t.integer "donor_id", limit: 4
    t.integer "item_id",  limit: 4
  end

  create_table "exhibition_venues", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "address_line_one",   limit: 255
    t.string   "address_line_two",   limit: 255
    t.string   "city",               limit: 255
    t.string   "state",              limit: 255
    t.string   "zipcode",            limit: 255
    t.string   "country",            limit: 255
    t.string   "phone",              limit: 255
    t.string   "contact_first_name", limit: 255
    t.string   "contact_last_name",  limit: 255
    t.string   "contact_position",   limit: 255
    t.string   "contact_email",      limit: 255
    t.string   "website",            limit: 255
    t.string   "notes",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exhibitions", force: :cascade do |t|
    t.string   "title",               limit: 255
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "exhibition_venue_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exhibitions_works", id: false, force: :cascade do |t|
    t.integer "exhibition_id", limit: 4
    t.integer "work_id",       limit: 4
  end

  create_table "image_colors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "image_colors_items", id: false, force: :cascade do |t|
    t.integer "image_color_id", limit: 4
    t.integer "item_id",        limit: 4
  end

  create_table "image_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "image_types_items", id: false, force: :cascade do |t|
    t.integer "image_type_id", limit: 4
    t.integer "item_id",       limit: 4
  end

  create_table "items", force: :cascade do |t|
    t.string   "title",                       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "alphabetical_title",          limit: 255
    t.string   "subtitle",                    limit: 255
    t.string   "publisher_name",              limit: 255
    t.string   "publisher_city",              limit: 255
    t.string   "publisher_state",             limit: 255
    t.string   "publisher_country",           limit: 255
    t.string   "extent",                      limit: 255
    t.string   "copyright",                   limit: 255
    t.string   "item_size",                   limit: 255
    t.string   "call_number",                 limit: 255
    t.string   "collection_name",             limit: 255
    t.integer  "legacy_id",                   limit: 4
    t.string   "cover_image_file_name",       limit: 255
    t.string   "cover_image_content_type",    limit: 255
    t.integer  "cover_image_image_file_size", limit: 4
    t.datetime "cover_image_updated_at"
    t.string   "barcode",                     limit: 255
    t.boolean  "has_marc_record",             limit: 1
    t.text     "metadata_notes",              limit: 65535
    t.string   "corporate_author",            limit: 255
    t.string   "isbn_issn",                   limit: 255
    t.boolean  "is_government_document",      limit: 1
    t.string   "edition",                     limit: 255
    t.text     "notes",                       limit: 65535
    t.string   "series_name",                 limit: 255
    t.boolean  "needs_translation",           limit: 1
    t.string   "location",                    limit: 255
    t.boolean  "is_marked",                   limit: 1
    t.integer  "vendor_id",                   limit: 4
    t.date     "date_acquired"
    t.decimal  "price_paid",                                precision: 8, scale: 2
    t.string   "acquisition_type",            limit: 255
    t.text     "acquisition_note",            limit: 65535
    t.string   "acquired_for",                limit: 255
    t.integer  "legacy_record_id",            limit: 4
    t.string   "cataloging_status",           limit: 255
    t.string   "provenance",                  limit: 255
    t.text     "dedication",                  limit: 65535
    t.string   "physical_format",             limit: 255
    t.datetime "published_at"
    t.text     "inscription",                 limit: 65535
  end

  create_table "items2", force: :cascade do |t|
    t.string   "title",                       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "alphabetical_title",          limit: 255
    t.string   "subtitle",                    limit: 255
    t.string   "publisher_name",              limit: 255
    t.string   "publisher_city",              limit: 255
    t.string   "publisher_state",             limit: 255
    t.string   "publisher_country",           limit: 255
    t.string   "extent",                      limit: 255
    t.string   "copyright",                   limit: 255
    t.string   "item_size",                   limit: 255
    t.string   "call_number",                 limit: 255
    t.string   "collection_name",             limit: 255
    t.integer  "legacy_id",                   limit: 4
    t.string   "cover_image_file_name",       limit: 255
    t.string   "cover_image_content_type",    limit: 255
    t.integer  "cover_image_image_file_size", limit: 4
    t.datetime "cover_image_updated_at"
    t.string   "barcode",                     limit: 255
    t.boolean  "has_marc_record",             limit: 1
    t.text     "metadata_notes",              limit: 16777215
    t.string   "corporate_author",            limit: 255
    t.string   "isbn_issn",                   limit: 255
    t.boolean  "is_government_document",      limit: 1
    t.string   "edition",                     limit: 255
    t.text     "notes",                       limit: 16777215
    t.string   "series_name",                 limit: 255
    t.boolean  "needs_translation",           limit: 1
    t.string   "location",                    limit: 255
    t.boolean  "is_marked",                   limit: 1
    t.integer  "vendor_id",                   limit: 4
    t.date     "date_acquired"
    t.decimal  "price_paid",                                   precision: 8, scale: 2
    t.string   "acquisition_type",            limit: 255
    t.text     "acquisition_note",            limit: 16777215
    t.string   "acquired_for",                limit: 255
    t.integer  "legacy_record_id",            limit: 4
    t.string   "cataloging_status",           limit: 255
    t.string   "provenance",                  limit: 255
    t.text     "dedication",                  limit: 16777215
    t.string   "physical_format",             limit: 255
    t.datetime "published_at"
  end

  create_table "items_languages", id: false, force: :cascade do |t|
    t.integer "item_id",     limit: 4
    t.integer "language_id", limit: 4
  end

  create_table "items_subjects", id: false, force: :cascade do |t|
    t.integer "item_id",    limit: 4
    t.integer "subject_id", limit: 4
  end

  create_table "items_works", id: false, force: :cascade do |t|
    t.integer "item_id", limit: 4
    t.integer "work_id", limit: 4
  end

  create_table "languages", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "log_entries", force: :cascade do |t|
    t.integer  "process_log_id", limit: 4
    t.text     "message",        limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "process_logs", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "digital_asset_ingest_id", limit: 4
  end

  create_table "series", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "series_parts", force: :cascade do |t|
    t.integer  "item_id",           limit: 4
    t.integer  "series_id",         limit: 4
    t.integer  "position",          limit: 4
    t.string   "volume_identifier", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subject_authorities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authority",  limit: 255
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",               limit: 255
    t.string   "email",                  limit: 255
    t.string   "persistence_token",      limit: 255
    t.string   "encrypted_password",     limit: 255
    t.string   "password_salt",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",                   limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.string   "remember_token",         limit: 255
    t.datetime "remember_created_at"
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.integer  "failed_attempts",        limit: 4
    t.integer  "sign_in_count",          limit: 4
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "vendors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "street",     limit: 255
    t.string   "city",       limit: 255
    t.string   "state",      limit: 255
    t.string   "zip",        limit: 255
    t.string   "country",    limit: 255
    t.string   "url",        limit: 255
    t.string   "phone",      limit: 255
    t.string   "notes",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "legacy_id",  limit: 4
  end

  create_table "work_creators", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "work_creators_works", id: false, force: :cascade do |t|
    t.integer "work_id",         limit: 4
    t.integer "work_creator_id", limit: 4
  end

  create_table "work_images", force: :cascade do |t|
    t.integer  "work_id",            limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  create_table "works", force: :cascade do |t|
    t.string   "title",                 limit: 255
    t.string   "medium",                limit: 255
    t.string   "size",                  limit: 255
    t.integer  "year_created",          limit: 4
    t.string   "work_type",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id",            limit: 4
    t.integer  "legacy_id",             limit: 4
    t.string   "textfile_file_name",    limit: 255
    t.string   "textfile_content_type", limit: 255
    t.integer  "textfile_file_size",    limit: 4
    t.datetime "textfile_updated_at"
  end

end
