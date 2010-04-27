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

ActiveRecord::Schema.define(:version => 20100422215442) do

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
  end

  create_table "items_subjects", :id => false, :force => true do |t|
    t.integer "item_id"
    t.integer "subject_id"
  end

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
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