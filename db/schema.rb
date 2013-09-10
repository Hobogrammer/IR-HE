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

ActiveRecord::Schema.define(version: 20130728035509) do

  create_table "texts", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.string   "language"
    t.string   "tags",                       array: true
    t.boolean  "share",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.string   "tz"
    t.boolean  "admin",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
  end

  create_table "words", force: true do |t|
    t.string   "term"
    t.string   "reading"
    t.string   "definition"
    t.string   "sentence"
    t.string   "tags",                       array: true
    t.integer  "user_id"
    t.integer  "text_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "shared",     default: false
  end

end