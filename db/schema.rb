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

ActiveRecord::Schema.define(version: 20131023022929) do

  create_table "translations", force: true do |t|
    t.string   "translation",              null: false
    t.integer  "like_counter", default: 0
    t.integer  "word_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "translations", ["like_counter"], name: "like_counter"
  add_index "translations", ["translation"], name: "translation"

  create_table "words", force: true do |t|
    t.string   "word",                     null: false
    t.integer  "view_counter", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "words", ["view_counter"], name: "view_counter"
  add_index "words", ["word"], name: "word", unique: true

end
