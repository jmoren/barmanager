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

ActiveRecord::Schema.define(version: 20150106223104) do

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

  add_index "expenses", ["shift_id"], name: "index_expenses_on_shift_id"

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
    t.integer  "stock"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "code"
    t.float    "night_price"
  end

  add_index "items", ["code"], name: "index_items_on_code", unique: true

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
  end

  add_index "promotions", ["code"], name: "index_promotions_on_code", unique: true

  create_table "shifts", force: true do |t|
    t.datetime "open"
    t.datetime "close"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "closing_cash"
    t.float    "opening_cash"
  end

  create_table "tables", force: true do |t|
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.string   "description"
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

  add_index "tickets", ["shift_id"], name: "index_tickets_on_shift_id"

end
