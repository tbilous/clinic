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

ActiveRecord::Schema.define(version: 20160917122822) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "anthropometries", force: :cascade do |t|
    t.date     "date",         default: '2016-08-31', null: false
    t.string   "comment"
    t.float    "weight"
    t.float    "height"
    t.float    "cranium"
    t.float    "chest"
    t.integer  "user_id",                             null: false
    t.integer  "character_id",                        null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "anthropometries", ["character_id", "created_at"], name: "index_anthropometries_on_character_id_and_created_at", using: :btree

  create_table "characters", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "comment",    default: ""
    t.date     "birthday",                  null: false
    t.boolean  "sex",                       null: false
    t.boolean  "usd",        default: true
    t.integer  "user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "aasm_state"
  end

  add_index "characters", ["user_id", "created_at"], name: "index_characters_on_user_id_and_created_at", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "name",       null: false
    t.text     "comment",    null: false
    t.text     "address",    null: false
    t.string   "phone",      null: false
    t.string   "email",      null: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "photo_uid"
  end

  add_index "contacts", ["user_id", "created_at"], name: "index_contacts_on_user_id_and_created_at", using: :btree

  create_table "pharm_groups", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "name",       null: false
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pharm_groups", ["user_id"], name: "index_pharm_groups_on_user_id", using: :btree

  create_table "pharm_owners", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "name",       null: false
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pharm_owners", ["user_id"], name: "index_pharm_owners_on_user_id", using: :btree

  create_table "pharm_types", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "name",       null: false
    t.string   "slug",       null: false
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pharm_types", ["user_id"], name: "index_pharm_types_on_user_id", using: :btree

  create_table "pharms", force: :cascade do |t|
    t.integer  "user_id",        null: false
    t.string   "name",           null: false
    t.text     "comment",        null: false
    t.string   "attention"
    t.float    "dose",           null: false
    t.float    "volume",         null: false
    t.integer  "pharm_type_id"
    t.integer  "pharm_owner_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "pharms", ["user_id"], name: "index_pharms_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.boolean  "admin",                  default: false
    t.integer  "patient"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
