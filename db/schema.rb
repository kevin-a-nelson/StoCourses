# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_08_02_074844) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_labs", force: :cascade do |t|
    t.integer "lab_id"
    t.integer "course_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "course_terms", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "course_id"
    t.integer "term_id"
  end

  create_table "courses", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "clbid"
    t.string "crsid"
    t.string "department"
    t.text "description"
    t.integer "enrolled"
    t.string "gereqs"
    t.string "instructors"
    t.integer "level"
    t.integer "max"
    t.string "name"
    t.text "notes"
    t.integer "number"
    t.string "offerings"
    t.boolean "pn"
    t.string "prerequisites"
    t.text "revisions"
    t.string "section"
    t.integer "semester"
    t.string "status"
    t.integer "term"
    t.integer "year"
    t.string "days"
    t.string "times"
    t.string "location"
    t.boolean "firstyear"
    t.boolean "sophmore"
    t.boolean "junior"
    t.boolean "senior"
    t.string "course_type"
    t.decimal "credits", precision: 5, scale: 2
    t.index ["term"], name: "index_courses_on_term"
  end

  create_table "planners", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
  end

  create_table "terms", force: :cascade do |t|
    t.integer "year"
    t.integer "semester"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "planner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "enrollment_year"
  end

end
