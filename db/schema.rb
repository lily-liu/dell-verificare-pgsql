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

ActiveRecord::Schema.define(version: 20161202042759) do

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
    t.integer  "region_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["region_id"], name: "index_cities_on_region_id", using: :btree
  end

  create_table "conflicted_inventories", force: :cascade do |t|
    t.string   "service_tag",                 null: false
    t.integer  "user_id"
    t.integer  "store_id"
    t.integer  "cause",       default: 0
    t.boolean  "solved",      default: false
    t.datetime "deleted_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["store_id"], name: "index_conflicted_inventories_on_store_id", using: :btree
    t.index ["user_id"], name: "index_conflicted_inventories_on_user_id", using: :btree
  end

  create_table "conflicted_sellouts", force: :cascade do |t|
    t.string   "service_tag",                 null: false
    t.integer  "user_id"
    t.integer  "store_id"
    t.integer  "cause",       default: 0
    t.boolean  "solved",      default: false
    t.datetime "deleted_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["store_id"], name: "index_conflicted_sellouts_on_store_id", using: :btree
    t.index ["user_id"], name: "index_conflicted_sellouts_on_user_id", using: :btree
  end

  create_table "inventories", force: :cascade do |t|
    t.string   "service_tag",             null: false
    t.integer  "status",      default: 0
    t.integer  "sellin_id"
    t.integer  "store_id"
    t.integer  "added_by"
    t.integer  "user_id"
    t.string   "csv_ref"
    t.datetime "deleted_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["sellin_id"], name: "index_inventories_on_sellin_id", using: :btree
    t.index ["service_tag"], name: "index_inventories_on_service_tag", unique: true, using: :btree
    t.index ["store_id"], name: "index_inventories_on_store_id", using: :btree
    t.index ["user_id"], name: "index_inventories_on_user_id", using: :btree
  end

  create_table "issues", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "store_id"
    t.string   "program_name",               null: false
    t.string   "brand_name",                 null: false
    t.string   "store_name",                 null: false
    t.integer  "impact",         default: 0
    t.datetime "campaign_start",             null: false
    t.datetime "campaign_end"
    t.string   "remark"
    t.string   "photo_name",                 null: false
    t.datetime "deleted_at"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["store_id"], name: "index_issues_on_store_id", using: :btree
    t.index ["user_id"], name: "index_issues_on_user_id", using: :btree
  end

  create_table "managers", force: :cascade do |t|
    t.string   "name",                   null: false
    t.integer  "parent_id"
    t.integer  "level",      default: 0
    t.datetime "deleted_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "posm_store_inventories", force: :cascade do |t|
    t.integer  "posm_id"
    t.integer  "store_id"
    t.integer  "user_id"
    t.integer  "quantity",   null: false
    t.string   "visibility", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["posm_id"], name: "index_posm_store_inventories_on_posm_id", using: :btree
    t.index ["store_id"], name: "index_posm_store_inventories_on_store_id", using: :btree
    t.index ["user_id"], name: "index_posm_store_inventories_on_user_id", using: :btree
  end

  create_table "posms", force: :cascade do |t|
    t.string   "name",                   null: false
    t.integer  "category",   default: 0
    t.integer  "quantity",               null: false
    t.datetime "deleted_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.string   "content",    null: false
    t.integer  "user_id"
    t.integer  "level",      null: false
    t.integer  "parent_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "regions", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "position",   null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sell_kits", force: :cascade do |t|
    t.string   "name",                    null: false
    t.text     "description"
    t.string   "file_name",               null: false
    t.integer  "category",    default: 0
    t.integer  "family"
    t.datetime "deleted_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "sellins", force: :cascade do |t|
    t.string   "service_tag",  null: false
    t.integer  "quarter_year", null: false
    t.integer  "quarter",      null: false
    t.integer  "quarter_week", null: false
    t.integer  "item_type",    null: false
    t.string   "part_number"
    t.string   "product_type"
    t.string   "product_name"
    t.integer  "source_store", null: false
    t.integer  "target_store", null: false
    t.string   "csv_ref"
    t.datetime "deleted_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["service_tag"], name: "index_sellins_on_service_tag", unique: true, using: :btree
  end

  create_table "sellouts", force: :cascade do |t|
    t.string   "service_tag",                                  null: false
    t.integer  "user_id"
    t.integer  "added_by"
    t.integer  "inventory_id"
    t.integer  "store_id"
    t.integer  "quarter_year",                                 null: false
    t.integer  "quarter",                                      null: false
    t.integer  "quarter_week",                                 null: false
    t.float    "price_idr"
    t.float    "price_usd"
    t.string   "proof",        default: "default.png",         null: false
    t.string   "csv_ref"
    t.datetime "sales_date",   default: '2016-12-30 09:17:49', null: false
    t.datetime "deleted_at"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.index ["inventory_id"], name: "index_sellouts_on_inventory_id", using: :btree
    t.index ["service_tag"], name: "index_sellouts_on_service_tag", unique: true, using: :btree
    t.index ["store_id"], name: "index_sellouts_on_store_id", using: :btree
    t.index ["user_id"], name: "index_sellouts_on_user_id", using: :btree
  end

  create_table "stores", force: :cascade do |t|
    t.string   "store_uid",                  null: false
    t.integer  "city_id"
    t.string   "name",                       null: false
    t.integer  "level",          default: 0
    t.string   "address",                    null: false
    t.string   "phone"
    t.string   "email"
    t.string   "store_building",             null: false
    t.integer  "store_category", default: 0
    t.string   "store_owner"
    t.datetime "deleted_at"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["city_id"], name: "index_stores_on_city_id", using: :btree
    t.index ["store_uid"], name: "index_stores_on_store_uid", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",                     null: false
    t.string   "password_digest",              null: false
    t.integer  "level",           default: 0
    t.integer  "manager_id"
    t.string   "name",            default: ""
    t.string   "email",                        null: false
    t.string   "phone",           default: ""
    t.integer  "gender",          default: 3
    t.datetime "deleted_at"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["manager_id"], name: "index_users_on_manager_id", using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  create_table "visibilities", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "store_id"
    t.integer  "category",   default: 0
    t.string   "visibility",             null: false
    t.string   "remark"
    t.datetime "deleted_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["store_id"], name: "index_visibilities_on_store_id", using: :btree
    t.index ["user_id"], name: "index_visibilities_on_user_id", using: :btree
  end

  add_foreign_key "absences", "stores"
  add_foreign_key "absences", "users"
  add_foreign_key "cities", "regions"
  add_foreign_key "conflicted_inventories", "stores"
  add_foreign_key "conflicted_inventories", "users"
  add_foreign_key "conflicted_sellouts", "stores"
  add_foreign_key "conflicted_sellouts", "users"
  add_foreign_key "inventories", "sellins"
  add_foreign_key "inventories", "stores"
  add_foreign_key "inventories", "users"
  add_foreign_key "inventories", "users", column: "added_by"
  add_foreign_key "issues", "stores"
  add_foreign_key "issues", "users"
  add_foreign_key "managers", "managers", column: "parent_id"
  add_foreign_key "posm_store_inventories", "posms"
  add_foreign_key "posm_store_inventories", "stores"
  add_foreign_key "posm_store_inventories", "users"
  add_foreign_key "posts", "posts", column: "parent_id"
  add_foreign_key "posts", "users"
  add_foreign_key "sellins", "stores", column: "source_store"
  add_foreign_key "sellins", "stores", column: "target_store"
  add_foreign_key "sellouts", "inventories"
  add_foreign_key "sellouts", "stores"
  add_foreign_key "sellouts", "users"
  add_foreign_key "sellouts", "users", column: "added_by"
  add_foreign_key "stores", "cities"
  add_foreign_key "users", "managers"
  add_foreign_key "visibilities", "stores"
  add_foreign_key "visibilities", "users"
end
