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

ActiveRecord::Schema.define(version: 20150629183251) do

  create_table "basics", force: :cascade do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "buildingType"
    t.integer  "buildingId"
    t.integer  "spaceCategory_id"
  end

  create_table "occupant_categories", force: :cascade do |t|
    t.string   "name"
    t.time     "ATypical"
    t.time     "AStart"
    t.time     "AEnd"
    t.time     "WMTypical"
    t.time     "WMStart"
    t.time     "WMEnd"
    t.time     "GTLTypical"
    t.time     "GTLStart"
    t.time     "GTLEnd"
    t.time     "BFLTypical"
    t.time     "BFLStart"
    t.time     "BFLEnd"
    t.time     "WATypical"
    t.time     "WAStart"
    t.time     "WAEnd"
    t.time     "DTypical"
    t.time     "DStart"
    t.time     "DEnd"
    t.integer  "ownPercent"
    t.time     "ownDuration"
    t.integer  "otherPercent"
    t.time     "otherDuration"
    t.integer  "meetingPercent"
    t.time     "meetingDuration"
    t.integer  "outPercent"
    t.time     "outDuration"
    t.integer  "basic_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "auxPercent"
    t.time     "auxDuration"
  end

  add_index "occupant_categories", ["basic_id"], name: "index_occupant_categories_on_basic_id"

  create_table "occupants", force: :cascade do |t|
    t.string   "occupantType"
    t.integer  "percentage"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "space_category_id"
  end

  create_table "space_categories", force: :cascade do |t|
    t.string   "name"
    t.decimal  "density"
    t.integer  "basic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "space_categories", ["basic_id"], name: "index_space_categories_on_basic_id"

  create_table "spaces", force: :cascade do |t|
    t.string   "name"
    t.string   "spaceType"
    t.integer  "multiplier"
    t.decimal  "area"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "basic_id"
  end

  add_index "spaces", ["basic_id"], name: "index_spaces_on_basic_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
