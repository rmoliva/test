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

ActiveRecord::Schema.define(version: 20170707141938) do

  create_table "products", force: :cascade do |t|
    t.string   "name",                   null: false
    t.float    "price",                  null: false
    t.integer  "rating",     default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "products", ["name"], name: "index_products_on_name", unique: true
  add_index "products", ["rating"], name: "index_products_on_rating"
  add_index "products", [nil], name: "index_products_on_number"

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "users", force: :cascade do |t|
    t.string   "name",                              null: false
    t.string   "surname"
    t.string   "email"
    t.string   "timezone",                          null: false
    t.string   "locale",                            null: false
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "perishable_token"
    t.integer  "login_count",        default: 0,    null: false
    t.integer  "failed_login_count", default: 0,    null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.boolean  "active",             default: true
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["name", "surname"], name: "index_users_on_name_and_surname"

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  limit: 191,        null: false
    t.integer  "item_id",                       null: false
    t.string   "event",                         null: false
    t.string   "whodunnit"
    t.text     "object",     limit: 1073741823
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
