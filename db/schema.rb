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

ActiveRecord::Schema.define(version: 20150731171805) do

  create_table "basics", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "buildingType"
    t.integer  "buildingId"
    t.decimal  "total_area"
    t.integer  "session_number"
    t.integer  "start_year"
    t.integer  "start_mon"
    t.integer  "start_day"
    t.integer  "end_year"
    t.integer  "end_mon"
    t.integer  "end_day"
    t.integer  "time_step"
    t.integer  "space_num"
    t.integer  "isModified"
  end

  create_table "meetings", force: :cascade do |t|
    t.decimal  "prob"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "space_category_id"
    t.integer  "duration"
    t.string   "start_time"
    t.string   "end_time"
    t.text     "time_range"
  end

  add_index "meetings", ["space_category_id"], name: "index_meetings_on_space_category_id"

  create_table "movement_behaviors", force: :cascade do |t|
    t.string   "event_type"
    t.string   "ATypical"
    t.string   "AStart"
    t.string   "AEnd"
    t.string   "GTLTypical"
    t.string   "GTLStart"
    t.string   "GTLEnd"
    t.string   "BFLTypical"
    t.string   "BFLStart"
    t.string   "BFLEnd"
    t.string   "DTypical"
    t.string   "DStart"
    t.string   "DEnd"
    t.integer  "ownPercent"
    t.integer  "ownDuration"
    t.integer  "otherPercent"
    t.integer  "otherDuration"
    t.integer  "meetingPercent"
    t.integer  "meetingDuration"
    t.integer  "auxPercent"
    t.integer  "auxDuration"
    t.integer  "outPercent"
    t.integer  "outDuration"
    t.integer  "occupant_category_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "isWorking"
  end

  add_index "movement_behaviors", ["occupant_category_id"], name: "index_movement_behaviors_on_occupant_category_id"

  create_table "occupant_categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "basic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "event_type"
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
    t.string   "energy_use"
    t.integer  "max_num"
    t.integer  "min_num"
    t.string   "usage"
    t.text     "err"
  end

  add_index "space_categories", ["basic_id"], name: "index_space_categories_on_basic_id"

  create_table "spaces", force: :cascade do |t|
    t.string   "name"
    t.string   "spaceType"
    t.integer  "multiplier"
    t.decimal  "area"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "basic_id"
    t.integer  "occupant_num"
  end

  add_index "spaces", ["basic_id"], name: "index_spaces_on_basic_id"

end
