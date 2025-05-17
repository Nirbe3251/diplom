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

ActiveRecord::Schema[7.0].define(version: 2025_05_17_092555) do
  create_table "attachments", charset: "utf8mb3", force: :cascade do |t|
    t.text "description", size: :tiny
    t.string "file_name"
    t.binary "file"
  end

  create_table "bug_reports", charset: "utf8mb3", force: :cascade do |t|
    t.text "description", size: :tiny, null: false
    t.text "full_description"
    t.text "steps"
    t.string "environment", limit: 150
    t.text "comment"
    t.bigint "project_id"
    t.bigint "severity_id"
    t.bigint "priority_id"
    t.bigint "status_id"
    t.integer "performer_id"
    t.string "title", limit: 50
    t.index ["priority_id"], name: "index_bug_reports_on_priority_id"
    t.index ["project_id"], name: "index_bug_reports_on_project_id"
    t.index ["severity_id"], name: "index_bug_reports_on_severity_id"
    t.index ["status_id"], name: "index_bug_reports_on_status_id"
  end

  create_table "checklist_modules", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.integer "position", default: 1, null: false
    t.bigint "checklist_id"
    t.index ["checklist_id"], name: "index_checklist_modules_on_checklist_id"
  end

  create_table "checklist_steps", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "checklist_id"
    t.integer "position"
    t.text "checklist_text"
    t.index ["checklist_id"], name: "index_checklist_steps_on_checklist_id"
  end

  create_table "checklists", charset: "utf8mb3", force: :cascade do |t|
    t.text "head", size: :tiny, null: false
    t.string "expected_result", limit: 100, null: false
    t.string "test_type", limit: 200
    t.bigint "status_id", default: 0, null: false
    t.bigint "project_id"
    t.index ["project_id"], name: "index_checklists_on_project_id"
    t.index ["status_id"], name: "index_checklists_on_status_id"
  end

  create_table "module_checks", charset: "utf8mb3", force: :cascade do |t|
    t.integer "position", default: 1, null: false
    t.text "module_step", null: false
    t.bigint "checklist_module_id"
    t.index ["checklist_module_id"], name: "index_module_checks_on_checklist_module_id"
  end

  create_table "priorities", charset: "utf8mb3", force: :cascade do |t|
    t.string "title"
    t.integer "priority_level", null: false
  end

  create_table "project_users", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "user_id", null: false
    t.index ["project_id"], name: "index_project_users_on_project_id"
    t.index ["user_id"], name: "index_project_users_on_user_id"
  end

  create_table "projects", charset: "utf8mb3", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.bigint "user_id", null: false
    t.datetime "start_at", null: false
    t.datetime "end_at"
    t.index ["title"], name: "index_projects_on_title"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "roles", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", limit: 45, null: false
    t.integer "create_test_case", default: 0
    t.integer "create_check_list", default: 0
    t.integer "create_test_plan", default: 0
    t.integer "create_bug_report", default: 0
  end

  create_table "severities", charset: "utf8mb3", force: :cascade do |t|
    t.string "title"
    t.integer "severity_level", default: 0, null: false
  end

  create_table "status_bug_reports", charset: "utf8mb3", force: :cascade do |t|
    t.string "title", limit: 10
    t.integer "step", null: false
  end

  create_table "status_checklists", charset: "utf8mb3", force: :cascade do |t|
    t.boolean "completed", default: false
  end

  create_table "test_cases", id: false, charset: "utf8mb3", force: :cascade do |t|
    t.string "id", null: false
    t.string "title", limit: 45, null: false
    t.text "steps", null: false
    t.string "expected_result", limit: 100, null: false
    t.string "requirement", limit: 2048
    t.string "test_module", limit: 25
    t.text "test_data", size: :tiny
    t.text "postconditions", size: :tiny
    t.boolean "state"
    t.bigint "priority_id"
    t.bigint "project_id"
    t.bigint "user_id"
    t.index ["priority_id"], name: "index_test_cases_on_priority_id"
    t.index ["project_id"], name: "index_test_cases_on_project_id"
    t.index ["user_id"], name: "index_test_cases_on_user_id"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "email", limit: 45, default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", limit: 45, null: false
    t.string "surname", limit: 45, null: false
    t.integer "admin", limit: 1, default: 0
    t.datetime "created_at", null: false
    t.bigint "roles_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["roles_id"], name: "index_users_on_roles_id"
  end

  add_foreign_key "users", "roles", column: "roles_id"
end
