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

ActiveRecord::Schema.define(version: 20161128085332) do

  create_table "applicants", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "region"
    t.string   "phone"
    t.string   "email"
    t.string   "phone_type"
    t.string   "source"
    t.boolean  "over_21"
    t.text     "reason"
    t.string   "workflow_state"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "state"
    t.boolean  "background_check_acceptance"
  end

end
