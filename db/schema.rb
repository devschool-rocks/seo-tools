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

ActiveRecord::Schema.define(version: 20160105191913) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "domains", force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grade_points", force: :cascade do |t|
    t.integer  "importance_id"
    t.string   "label"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "grade_points", ["importance_id"], name: "index_grade_points_on_importance_id", using: :btree

  create_table "importances", force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "keywords", force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rankings", force: :cascade do |t|
    t.integer  "keyword_id"
    t.string   "url"
    t.integer  "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "rankings", ["keyword_id"], name: "index_rankings_on_keyword_id", using: :btree

  create_table "seo_grade_points", force: :cascade do |t|
    t.integer  "seo_grade_id"
    t.integer  "grade_point_id"
    t.integer  "score"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "seo_grade_points", ["grade_point_id"], name: "index_seo_grade_points_on_grade_point_id", using: :btree
  add_index "seo_grade_points", ["seo_grade_id"], name: "index_seo_grade_points_on_seo_grade_id", using: :btree

  create_table "seo_grades", force: :cascade do |t|
    t.integer  "keyword_id"
    t.string   "url"
    t.string   "grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "seo_grades", ["keyword_id"], name: "index_seo_grades_on_keyword_id", using: :btree

  add_foreign_key "grade_points", "importances"
  add_foreign_key "rankings", "keywords"
  add_foreign_key "seo_grade_points", "grade_points"
  add_foreign_key "seo_grade_points", "seo_grades"
  add_foreign_key "seo_grades", "keywords"
end
