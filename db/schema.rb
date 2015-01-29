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

ActiveRecord::Schema.define(version: 20150127125120) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "additionals", force: true do |t|
    t.string  "description"
    t.float   "amount"
    t.integer "ticket_id"
  end

  add_index "additionals", ["ticket_id"], name: "index_additionals_on_ticket_id", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expenses", force: true do |t|
    t.string  "description"
    t.float   "amount"
    t.integer "shift_id"
  end

  add_index "expenses", ["shift_id"], name: "index_expenses_on_shift_id", using: :btree

  create_table "item_tickets", force: true do |t|
    t.integer  "ticket_id"
    t.integer  "item_id"
    t.integer  "quantity"
    t.float    "sub_total"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.string   "description"
    t.float    "day_price"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "code"
    t.float    "night_price"
    t.boolean  "favourite",   default: false
  end

  add_index "items", ["code"], name: "index_items_on_code", unique: true, using: :btree

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "promotion_items", force: true do |t|
    t.integer  "item_id"
    t.integer  "promotion_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "promotion_ticket_items", force: true do |t|
    t.integer "promotion_ticket_id"
    t.integer "promotion_item_id"
    t.integer "delivered",           default: 0
  end

  add_index "promotion_ticket_items", ["promotion_item_id"], name: "index_promotion_ticket_items_on_promotion_item_id", using: :btree

  create_table "promotion_tickets", force: true do |t|
    t.integer  "ticket_id"
    t.integer  "promotion_id"
    t.integer  "quantity"
    t.float    "subtotal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "promotions", force: true do |t|
    t.string   "description"
    t.float    "day_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "night_price"
    t.integer  "code"
    t.boolean  "favourite",   default: false
  end

  add_index "promotions", ["code"], name: "index_promotions_on_code", unique: true, using: :btree

  create_table "shifts", force: true do |t|
    t.datetime "open"
    t.datetime "close"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "closing_cash"
    t.float    "opening_cash"
  end

  create_table "tables", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.string   "description"
    t.string   "color",       default: "#27292B"
  end

  create_table "tickets", force: true do |t|
    t.integer  "table_id"
    t.datetime "date"
    t.float    "total"
    t.integer  "payment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.integer  "number"
    t.integer  "shift_id"
  end

  add_index "tickets", ["shift_id"], name: "index_tickets_on_shift_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree
end
