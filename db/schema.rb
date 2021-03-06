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

ActiveRecord::Schema.define(version: 20160713173747) do

  create_table "people", force: :cascade do |t|
    t.string  "name",          limit: 32, null: false
    t.string  "gender",        limit: 1
    t.string  "house",         limit: 32
    t.integer "father",        limit: 4
    t.integer "mother",        limit: 4
    t.integer "year_of_birth", limit: 4
    t.integer "year_of_death", limit: 4
    t.string  "wiki_link",     limit: 64
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "person_1",   limit: 4
    t.integer "person_2",   limit: 4
    t.boolean "legitimate"
  end

end
