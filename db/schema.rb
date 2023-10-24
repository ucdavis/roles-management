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

ActiveRecord::Schema.define(version: 2023_10_24_224358) do

  create_table "api_key_users", id: { type: :bigint, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.string "secret"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.datetime "logged_in_at", precision: 6
    t.index ["id"], name: "id", unique: true
    t.index ["name", "secret"], name: "index_api_key_users_on_name_and_secret"
  end

  create_table "api_whitelisted_ip_users", id: { type: :bigint, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "reason"
    t.datetime "logged_in_at", precision: 6
    t.index ["address"], name: "index_api_whitelisted_ip_users_on_address"
    t.index ["id"], name: "id", unique: true
  end

  create_table "application_operatorships", id: { type: :bigint, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.integer "application_id"
    t.integer "entity_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "parent_id"
    t.index ["application_id", "entity_id", "parent_id"], name: "idx_app_operatorships_on_app_id_and_entity_id_and_parent_id"
    t.index ["id"], name: "id", unique: true
  end

  create_table "application_ownerships", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "entity_id"
    t.integer "application_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "parent_id"
  end

  create_table "applications", id: { type: :bigint, unsigned: true }, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description", size: :medium
    t.string "url"
    t.index ["id"], name: "id", unique: true
    t.index ["name"], name: "index_applications_on_name"
  end

  create_table "business_office_units", charset: "utf8", force: :cascade do |t|
    t.string "org_oid"
    t.string "dept_code"
    t.string "dept_official_name"
    t.string "dept_display_name"
    t.string "dept_abbrev"
    t.boolean "is_ucdhs"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "delayed_jobs", id: { type: :bigint, unsigned: true }, charset: "utf8", force: :cascade do |t|
    t.integer "priority", default: 0
    t.integer "attempts", default: 0
    t.text "handler", size: :medium
    t.text "last_error", size: :medium
    t.datetime "run_at", precision: 6
    t.datetime "locked_at", precision: 6
    t.datetime "failed_at", precision: 6
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["id"], name: "id", unique: true
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "departments", charset: "utf8", force: :cascade do |t|
    t.string "code", null: false
    t.string "officialName", null: false
    t.string "displayName"
    t.string "abbreviation", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "bou_org_oid"
  end

  create_table "entities", id: { type: :bigint, unsigned: true }, charset: "utf8", force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.string "first"
    t.string "last"
    t.string "email"
    t.string "loginid"
    t.boolean "active", default: true
    t.string "phone"
    t.string "address"
    t.text "description", size: :medium
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "logged_in_at", precision: 6
    t.boolean "is_employee"
    t.boolean "is_hs_employee"
    t.boolean "is_faculty"
    t.boolean "is_student"
    t.boolean "is_staff"
    t.boolean "is_external"
    t.integer "iam_id"
    t.string "ad_upn"
    t.string "ad_proxy_addresses"
    t.datetime "synced_at", precision: 6
    t.index ["id"], name: "id", unique: true
    t.index ["id"], name: "index_entities_on_id"
    t.index ["loginid"], name: "index_entities_on_loginid"
    t.index ["name"], name: "index_entities_on_name"
    t.index ["type"], name: "index_entities_on_type"
  end

  create_table "group_memberships", id: { type: :bigint, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.integer "group_id"
    t.integer "entity_id"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["id"], name: "id", unique: true
  end

  create_table "group_operatorships", id: { type: :bigint, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.integer "group_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "entity_id"
    t.index ["id"], name: "id", unique: true
  end

  create_table "group_ownerships", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "group_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "entity_id"
  end

  create_table "group_rule_result_sets", charset: "latin1", force: :cascade do |t|
    t.string "column"
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "group_rule_results", id: { type: :bigint, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.integer "group_rule_result_set_id"
    t.integer "entity_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["id"], name: "id", unique: true
  end

  create_table "group_rules", id: { type: :bigint, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.string "column"
    t.string "condition"
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "group_id"
    t.integer "group_rule_result_set_id"
    t.index ["id"], name: "id", unique: true
  end

  create_table "integration_metadata", charset: "latin1", force: :cascade do |t|
    t.string "key"
    t.text "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "majors", id: { type: :bigint, unsigned: true }, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.string "gr_code", limit: 5
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["id"], name: "id", unique: true
    t.index ["name"], name: "index_majors_on_name"
  end

  create_table "person_favorite_assignments", id: { type: :bigint, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.integer "entity_id"
    t.integer "owner_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["id"], name: "id", unique: true
  end

  create_table "pps_associations", charset: "latin1", force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "title_id", null: false
    t.integer "department_id", null: false
    t.integer "association_rank", null: false
    t.integer "position_type_code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "admin_department_id"
    t.integer "appt_department_id"
    t.integer "employee_class"
  end

  create_table "role_assignments", id: { type: :bigint, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role_id"
    t.integer "entity_id"
    t.integer "parent_id"
    t.index ["id"], name: "id", unique: true
    t.index ["role_id", "entity_id", "parent_id"], name: "index_role_assignments_on_role_id_and_entity_id_and_parent_id"
    t.index ["role_id", "entity_id"], name: "index_role_assignments_on_role_id_and_entity_id"
  end

  create_table "roles", id: { type: :bigint, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "application_id"
    t.string "name"
    t.string "description"
    t.string "ad_path"
    t.datetime "last_ad_sync", precision: 6
    t.string "ad_guid"
    t.datetime "last_accessed", precision: 6
    t.index ["id"], name: "id", unique: true
    t.index ["id"], name: "index_roles_on_id"
  end

  create_table "sis_associations", charset: "latin1", force: :cascade do |t|
    t.integer "major_id"
    t.integer "entity_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "level_code", limit: 2
    t.integer "association_rank"
  end

  create_table "titles", id: { type: :bigint, unsigned: true }, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "unit", limit: 3
    t.index ["code"], name: "index_titles_on_code"
    t.index ["id"], name: "id", unique: true
  end

  create_table "tracked_items", charset: "utf8", force: :cascade do |t|
    t.string "kind"
    t.integer "item_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
