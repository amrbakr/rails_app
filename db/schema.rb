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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130527102543) do

  create_table "batches", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "title"
  end

  create_table "card_issues", :force => true do |t|
    t.string   "title"
    t.date     "startDate"
    t.date     "endDate"
    t.boolean  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "card_statuses", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "card_types", :force => true do |t|
    t.string   "title"
    t.integer  "expirationMonths"
    t.boolean  "isDefault"
    t.boolean  "premium"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "cards", :force => true do |t|
    t.integer  "amount"
    t.string   "number"
    t.date     "subscriptionDate"
    t.date     "expirationDate"
    t.boolean  "expired"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "user_id"
    t.string   "nameOnCard"
    t.integer  "type_id"
    t.integer  "issue_id"
    t.integer  "status_id"
    t.boolean  "sanityChecked"
    t.boolean  "called"
    t.boolean  "locked",           :default => false, :null => false
    t.integer  "batch_id"
    t.boolean  "kconfirm"
    t.boolean  "cconfirm"
    t.boolean  "printed"
    t.boolean  "receiptPrinted"
  end

  create_table "excelsheets", :force => true do |t|
    t.string   "name"
    t.string   "original_name"
    t.boolean  "deleted",       :default => false, :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.boolean  "isValid",       :default => false, :null => false
  end

  create_table "imports", :force => true do |t|
    t.string   "name"
    t.string   "originalName"
    t.boolean  "deleted",      :default => false, :null => false
    t.boolean  "isValid",      :default => false, :null => false
    t.integer  "type_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "importtypes", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "extension"
    t.boolean  "enabled"
    t.string   "mimetype"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "firstName"
    t.string   "lastName"
    t.string   "email"
    t.date     "dob"
    t.string   "mobile"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
