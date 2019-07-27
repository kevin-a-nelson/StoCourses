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

ActiveRecord::Schema.define(version: 2019_07_27_084533) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "clbid"
    t.decimal "credits", precision: 5
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
    t.string "type"
    t.integer "year"
    t.string "days"
    t.string "times"
    t.string "location"
    t.boolean "firstyear"
    t.boolean "sophmore"
    t.boolean "junior"
    t.boolean "senior"
  end

  create_table "selectors", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
