# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_10_05_042905) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "rule_requests", force: :cascade do |t|
    t.bigint "rule_id", null: false
    t.bigint "user_id", null: false
    t.text "request_details", null: false
    t.string "status", default: "pending", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rule_id"], name: "index_rule_requests_on_rule_id"
    t.index ["user_id"], name: "index_rule_requests_on_user_id"
  end

  create_table "rules", force: :cascade do |t|
    t.string "title"
    t.bigint "team_name_id", null: false
    t.text "details"
    t.text "background"
    t.datetime "ended_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_name_id"], name: "index_rules_on_team_name_id"
  end

  create_table "team_names", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_team_names_on_name", unique: true
  end

  create_table "team_names_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "team_name_id", null: false
    t.index ["team_name_id", "user_id"], name: "index_team_names_users_on_team_name_id_and_user_id"
    t.index ["user_id", "team_name_id"], name: "index_team_names_users_on_user_id_and_team_name_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "username"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "rule_requests", "rules"
  add_foreign_key "rule_requests", "users"
  add_foreign_key "rules", "team_names"
end
