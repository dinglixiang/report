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

ActiveRecord::Schema.define(version: 20170319034610) do

  create_table "purchases", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "size"
    t.string   "unit"
    t.string   "company"
    t.datetime "purchase_date"
    t.integer  "purchase_volume"
    t.string   "upstream_client"
    t.index ["company"], name: "index_purchases_on_company", using: :btree
    t.index ["name"], name: "index_purchases_on_name", using: :btree
    t.index ["purchase_date"], name: "index_purchases_on_purchase_date", using: :btree
    t.index ["size"], name: "index_purchases_on_size", using: :btree
    t.index ["unit"], name: "index_purchases_on_unit", using: :btree
    t.index ["upstream_client"], name: "index_purchases_on_upstream_client", using: :btree
    t.index ["user_id"], name: "index_user_id", using: :btree
  end

  create_table "reports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "size"
    t.string   "unit"
    t.string   "company"
    t.datetime "sell_date"
    t.string   "target_company"
    t.integer  "sell_volume"
    t.index ["user_id"], name: "index_user_id", using: :btree
  end

  create_table "stocks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.string  "name"
    t.string  "size"
    t.string  "unit"
    t.string  "company"
    t.integer "stock_volume"
    t.index ["name"], name: "index_stocks_on_name", using: :btree
    t.index ["user_id"], name: "index_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "username",        limit: 20
    t.string "password_digest"
    t.string "salt",            limit: 30
    t.index ["username"], name: "index_users_on_username", using: :btree
  end

end
