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

ActiveRecord::Schema.define(version: 20161121083252) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "absences", force: :cascade do |t|
    t.integer  "absence_type", default: 0
    t.integer  "user_id"
    t.integer  "store_id"
    t.float    "latitude",     default: 0.0
    t.float    "longitude",    default: 0.0
    t.string   "remark"
    t.datetime "deleted_at"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["store_id"], name: "index_absences_on_store_id", using: :btree
    t.index ["user_id"], name: "index_absences_on_user_id", using: :btree
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "issues", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "program_name",   null: false
    t.string   "brand_name",     null: false
    t.string   "store_name",     null: false
    t.datetime "campaign_start", null: false
    t.datetime "campaign_end"
    t.string   "remark"
    t.string   "photo_name",     null: false
    t.datetime "deleted_at"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["user_id"], name: "index_issues_on_user_id", using: :btree
  end

  create_table "product_knowledges", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.string   "file_name",   null: false
    t.datetime "deleted_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string   "store_uid",  null: false
    t.integer  "city_id"
    t.string   "name",       null: false
    t.string   "address",    null: false
    t.string   "phone"
    t.string   "email"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_stores_on_city_id", using: :btree
    t.index ["store_uid"], name: "index_stores_on_store_uid", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",                     null: false
    t.string   "password_digest",              null: false
    t.integer  "level",           default: 0
    t.string   "name",            default: ""
    t.string   "email",                        null: false
    t.string   "phone",           default: ""
    t.integer  "gender",          default: 3
    t.datetime "deleted_at"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  add_foreign_key "absences", "stores"
  add_foreign_key "absences", "users"
  add_foreign_key "issues", "users"
  add_foreign_key "stores", "cities"
end
