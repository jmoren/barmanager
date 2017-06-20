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

ActiveRecord::Schema.define(version: 20170620043346) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "additionals", force: :cascade do |t|
    t.string   "description"
    t.float    "amount"
    t.integer  "ticket_id"
    t.boolean  "kitchen"
    t.boolean  "delivered",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cancel_reason_id"
    t.datetime "deleted_at"
  end

  add_index "additionals", ["cancel_reason_id"], name: "index_additionals_on_cancel_reason_id", using: :btree
  add_index "additionals", ["deleted_at"], name: "index_additionals_on_deleted_at", using: :btree
  add_index "additionals", ["ticket_id"], name: "index_additionals_on_ticket_id", using: :btree

  create_table "cancel_reasons", force: :cascade do |t|
    t.string   "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "kitchen",    default: false
  end

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "doubt",      default: 0.0
  end

  add_index "clients", ["name"], name: "index_clients_on_name", using: :btree

  create_table "comments", force: :cascade do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "daily_cashes", force: :cascade do |t|
    t.integer  "total"
    t.boolean  "close",          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
    t.float    "total_expenses"
  end

  create_table "expenses", force: :cascade do |t|
    t.string   "description"
    t.float    "amount"
    t.integer  "shift_or_user_id"
    t.string   "shift_or_user_type", default: "Shift"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "supplier_id"
    t.date     "date"
  end

  add_index "expenses", ["shift_or_user_id"], name: "index_expenses_on_shift_or_user_id", using: :btree
  add_index "expenses", ["supplier_id"], name: "index_expenses_on_supplier_id", using: :btree

  create_table "extractions", force: :cascade do |t|
    t.integer  "amount"
    t.string   "description"
    t.integer  "shift_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "personal",    default: false
  end

  add_index "extractions", ["shift_id"], name: "index_extractions_on_shift_id", using: :btree
  add_index "extractions", ["user_id"], name: "index_extractions_on_user_id", using: :btree

  create_table "item_tickets", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "item_id"
    t.integer  "quantity"
    t.float    "sub_total"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "delivered",        default: false
    t.datetime "deleted_at"
    t.integer  "cancel_reason_id"
  end

  add_index "item_tickets", ["cancel_reason_id"], name: "index_item_tickets_on_cancel_reason_id", using: :btree
  add_index "item_tickets", ["deleted_at"], name: "index_item_tickets_on_deleted_at", using: :btree
  add_index "item_tickets", ["item_id"], name: "index_item_tickets_on_item_id", using: :btree
  add_index "item_tickets", ["ticket_id"], name: "index_item_tickets_on_ticket_id", using: :btree

  create_table "items", force: :cascade do |t|
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

  create_table "monthly_cashes", force: :cascade do |t|
    t.float    "total"
    t.boolean  "close"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "total_expenses"
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "promotion_items", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "promotion_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "promotion_ticket_items", force: :cascade do |t|
    t.integer "promotion_ticket_id"
    t.integer "promotion_item_id"
    t.integer "delivered",           default: 0
  end

  add_index "promotion_ticket_items", ["promotion_item_id"], name: "index_promotion_ticket_items_on_promotion_item_id", using: :btree

  create_table "promotion_tickets", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "promotion_id"
    t.integer  "quantity"
    t.float    "subtotal"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "cancel_reason_id"
  end

  add_index "promotion_tickets", ["cancel_reason_id"], name: "index_promotion_tickets_on_cancel_reason_id", using: :btree
  add_index "promotion_tickets", ["deleted_at"], name: "index_promotion_tickets_on_deleted_at", using: :btree
  add_index "promotion_tickets", ["promotion_id"], name: "index_promotion_tickets_on_promotion_id", using: :btree
  add_index "promotion_tickets", ["ticket_id"], name: "index_promotion_tickets_on_ticket_id", using: :btree

  create_table "promotions", force: :cascade do |t|
    t.string   "description"
    t.float    "day_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "night_price"
    t.integer  "code"
    t.boolean  "favourite",   default: false
  end

  add_index "promotions", ["code"], name: "index_promotions_on_code", unique: true, using: :btree

  create_table "shifts", force: :cascade do |t|
    t.datetime "open"
    t.datetime "close"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "closing_cash"
    t.float    "opening_cash"
    t.integer  "user_id"
    t.float    "pending",        default: 0.0
    t.float    "payments",       default: 0.0
    t.boolean  "fiscal_printed", default: false
  end

  add_index "shifts", ["user_id"], name: "index_shifts_on_user_id", using: :btree

  create_table "supplier_tickets", force: :cascade do |t|
    t.float    "amount"
    t.integer  "supplier_id"
    t.integer  "shift_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.integer  "code_number"
  end

  add_index "supplier_tickets", ["shift_id"], name: "index_supplier_tickets_on_shift_id", using: :btree
  add_index "supplier_tickets", ["supplier_id"], name: "index_supplier_tickets_on_supplier_id", using: :btree

  create_table "suppliers", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tables", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.string   "description"
    t.string   "color",       default: ""
  end

  add_index "tables", ["description"], name: "index_tables_on_description", using: :btree
  add_index "tables", ["id"], name: "index_tables_on_id", using: :btree
  add_index "tables", ["status"], name: "index_tables_on_status", using: :btree

  create_table "ticket_payments", force: :cascade do |t|
    t.integer  "client_id"
    t.float    "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shift_id"
  end

  add_index "ticket_payments", ["client_id"], name: "index_ticket_payments_on_client_id", using: :btree
  add_index "ticket_payments", ["shift_id"], name: "index_ticket_payments_on_shift_id", using: :btree

  create_table "tickets", force: :cascade do |t|
    t.integer  "table_id"
    t.datetime "date"
    t.float    "total"
    t.integer  "payment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.integer  "number"
    t.integer  "shift_id"
    t.integer  "client_id"
    t.boolean  "credit",     default: false
    t.datetime "printed_at"
  end

  add_index "tickets", ["client_id"], name: "index_tickets_on_client_id", using: :btree
  add_index "tickets", ["printed_at"], name: "index_tickets_on_printed_at", using: :btree
  add_index "tickets", ["shift_id"], name: "index_tickets_on_shift_id", using: :btree

  create_table "users", force: :cascade do |t|
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
    t.string   "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "additionals", "cancel_reasons"
  add_foreign_key "item_tickets", "cancel_reasons"
  add_foreign_key "promotion_tickets", "cancel_reasons"
end
