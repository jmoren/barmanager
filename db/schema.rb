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

ActiveRecord::Schema.define(version: 20170613183404) do

  create_table "additionals", force: :cascade do |t|
    t.string   "description",      limit: 255
    t.float    "amount",           limit: 24
    t.integer  "ticket_id",        limit: 4
    t.boolean  "kitchen"
    t.boolean  "delivered",                    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cancel_reason_id", limit: 4
    t.datetime "deleted_at"
  end

  add_index "additionals", ["cancel_reason_id"], name: "index_additionals_on_cancel_reason_id", using: :btree
  add_index "additionals", ["deleted_at"], name: "index_additionals_on_deleted_at", using: :btree
  add_index "additionals", ["ticket_id"], name: "index_additionals_on_ticket_id", using: :btree

  create_table "cancel_reasons", force: :cascade do |t|
    t.string   "text",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "kitchen",                default: false
  end

  create_table "clients", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "doubt",      limit: 24,  default: 0.0
  end

  add_index "clients", ["name"], name: "index_clients_on_name", using: :btree

  create_table "daily_cashes", force: :cascade do |t|
    t.integer  "total",          limit: 4
    t.boolean  "close",                     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
    t.float    "total_expenses", limit: 24
  end

  create_table "expenses", force: :cascade do |t|
    t.string   "description",        limit: 255
    t.float    "amount",             limit: 24
    t.integer  "shift_or_user_id",   limit: 4
    t.string   "shift_or_user_type", limit: 255, default: "Shift"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "supplier_id",        limit: 4
    t.date     "date"
  end

  add_index "expenses", ["shift_or_user_id"], name: "index_expenses_on_shift_or_user_id", using: :btree
  add_index "expenses", ["supplier_id"], name: "index_expenses_on_supplier_id", using: :btree

  create_table "extractions", force: :cascade do |t|
    t.integer  "amount",      limit: 4
    t.string   "description", limit: 255
    t.integer  "shift_id",    limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "personal",                default: false
  end

  add_index "extractions", ["shift_id"], name: "index_extractions_on_shift_id", using: :btree
  add_index "extractions", ["user_id"], name: "index_extractions_on_user_id", using: :btree

  create_table "item_tickets", force: :cascade do |t|
    t.integer  "ticket_id",        limit: 4
    t.integer  "item_id",          limit: 4
    t.integer  "quantity",         limit: 4
    t.float    "sub_total",        limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "delivered",                   default: false
    t.datetime "deleted_at"
    t.integer  "cancel_reason_id", limit: 4
  end

  add_index "item_tickets", ["cancel_reason_id"], name: "index_item_tickets_on_cancel_reason_id", using: :btree
  add_index "item_tickets", ["created_at"], name: "created_at", using: :btree
  add_index "item_tickets", ["deleted_at"], name: "index_item_tickets_on_deleted_at", using: :btree
  add_index "item_tickets", ["item_id"], name: "index_item_tickets_on_item_id", using: :btree
  add_index "item_tickets", ["item_id"], name: "item_id", using: :btree
  add_index "item_tickets", ["ticket_id"], name: "index_item_tickets_on_ticket_id", using: :btree
  add_index "item_tickets", ["ticket_id"], name: "ticket_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "description", limit: 255
    t.float    "day_price",   limit: 24
    t.integer  "category_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "code",        limit: 4
    t.float    "night_price", limit: 24
    t.boolean  "favourite",               default: false
  end

  add_index "items", ["code"], name: "index_items_on_code", unique: true, using: :btree

  create_table "monthly_cashes", force: :cascade do |t|
    t.float    "total",          limit: 24
    t.boolean  "close"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "total_expenses", limit: 24
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "address",    limit: 255
    t.string   "phone",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "promotion_items", force: :cascade do |t|
    t.integer  "item_id",      limit: 4
    t.integer  "promotion_id", limit: 4
    t.integer  "quantity",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "promotion_ticket_items", force: :cascade do |t|
    t.integer "promotion_ticket_id", limit: 4
    t.integer "promotion_item_id",   limit: 4
    t.integer "delivered",           limit: 4, default: 0
  end

  add_index "promotion_ticket_items", ["promotion_item_id"], name: "index_promotion_ticket_items_on_promotion_item_id", using: :btree

  create_table "promotion_tickets", force: :cascade do |t|
    t.integer  "ticket_id",        limit: 4
    t.integer  "promotion_id",     limit: 4
    t.integer  "quantity",         limit: 4
    t.float    "subtotal",         limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "cancel_reason_id", limit: 4
  end

  add_index "promotion_tickets", ["cancel_reason_id"], name: "index_promotion_tickets_on_cancel_reason_id", using: :btree
  add_index "promotion_tickets", ["deleted_at"], name: "index_promotion_tickets_on_deleted_at", using: :btree
  add_index "promotion_tickets", ["promotion_id"], name: "index_promotion_tickets_on_promotion_id", using: :btree
  add_index "promotion_tickets", ["ticket_id"], name: "index_promotion_tickets_on_ticket_id", using: :btree

  create_table "promotions", force: :cascade do |t|
    t.string   "description", limit: 255
    t.float    "day_price",   limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "night_price", limit: 24
    t.integer  "code",        limit: 4
    t.boolean  "favourite",               default: false
  end

  add_index "promotions", ["code"], name: "index_promotions_on_code", unique: true, using: :btree

  create_table "shifts", force: :cascade do |t|
    t.datetime "open"
    t.datetime "close"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "closing_cash",   limit: 24
    t.float    "opening_cash",   limit: 24
    t.integer  "user_id",        limit: 4
    t.float    "pending",        limit: 24, default: 0.0
    t.float    "payments",       limit: 24, default: 0.0
    t.boolean  "fiscal_printed",            default: false
  end

  add_index "shifts", ["user_id"], name: "index_shifts_on_user_id", using: :btree

  create_table "supplier_tickets", force: :cascade do |t|
    t.float    "amount",      limit: 24
    t.integer  "supplier_id", limit: 4
    t.integer  "shift_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description", limit: 255
    t.integer  "code_number", limit: 4
  end

  add_index "supplier_tickets", ["shift_id"], name: "index_supplier_tickets_on_shift_id", using: :btree
  add_index "supplier_tickets", ["supplier_id"], name: "index_supplier_tickets_on_supplier_id", using: :btree

  create_table "suppliers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "address",    limit: 255
    t.string   "phone",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tables", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",      limit: 255
    t.string   "description", limit: 255
    t.string   "color",       limit: 255, default: ""
  end

  add_index "tables", ["description"], name: "index_tables_on_description", using: :btree
  add_index "tables", ["id"], name: "index_tables_on_id", using: :btree
  add_index "tables", ["status"], name: "index_tables_on_status", using: :btree

  create_table "ticket_payments", force: :cascade do |t|
    t.integer  "client_id",  limit: 4
    t.float    "amount",     limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shift_id",   limit: 4
  end

  add_index "ticket_payments", ["client_id"], name: "index_ticket_payments_on_client_id", using: :btree
  add_index "ticket_payments", ["shift_id"], name: "index_ticket_payments_on_shift_id", using: :btree

  create_table "tickets", force: :cascade do |t|
    t.integer  "table_id",   limit: 4
    t.datetime "date"
    t.float    "total",      limit: 24
    t.integer  "payment",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",     limit: 255
    t.integer  "number",     limit: 4
    t.integer  "shift_id",   limit: 4
    t.integer  "client_id",  limit: 4
    t.boolean  "credit",                 default: false
    t.datetime "printed_at"
  end

  add_index "tickets", ["client_id"], name: "index_tickets_on_client_id", using: :btree
  add_index "tickets", ["created_at"], name: "created_at", using: :btree
  add_index "tickets", ["printed_at"], name: "index_tickets_on_printed_at", using: :btree
  add_index "tickets", ["shift_id"], name: "index_tickets_on_shift_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                              default: false
    t.string   "username",               limit: 255
    t.string   "role",                   limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "additionals", "cancel_reasons"
  add_foreign_key "item_tickets", "cancel_reasons"
  add_foreign_key "promotion_tickets", "cancel_reasons"
end
