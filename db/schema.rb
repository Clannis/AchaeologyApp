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

ActiveRecord::Schema.define(version: 2020_06_08_132620) do

  create_table "artifacts", force: :cascade do |t|
    t.integer "local_id"
    t.string "artifact_type"
    t.string "description"
    t.integer "level_id"
  end

  create_table "dig_sites", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "archaeologist"
    t.integer "user_id"
  end

  create_table "levels", force: :cascade do |t|
    t.string "beg_depth"
    t.string "end_depth"
    t.integer "unit_id"
    t.string "local_id"
  end

  create_table "team_members", force: :cascade do |t|
    t.string "name"
    t.string "credentials"
    t.integer "age"
    t.string "email"
    t.string "phone_number"
    t.integer "dig_site_id"
  end

  create_table "units", force: :cascade do |t|
    t.string "size"
    t.integer "dig_site_id"
    t.string "local_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.string "admin"
  end

end