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

ActiveRecord::Schema.define(version: 20150813203931) do

  create_table "accounts", force: :cascade do |t|
    t.string   "agency"
    t.string   "account"
    t.string   "password"
    t.decimal  "balance"
    t.decimal  "transaction_balance"
    t.integer  "holder_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "cards", force: :cascade do |t|
    t.string   "number"
    t.datetime "expiration_date"
    t.string   "security_code"
    t.string   "password"
    t.integer  "account_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "holders", force: :cascade do |t|
    t.string   "name"
    t.string   "cpf"
    t.integer  "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
