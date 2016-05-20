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

ActiveRecord::Schema.define(version: 20150721190626) do

  create_table "activity_log_tag_associations", force: :cascade do |t|
    t.integer "activity_log_id"
    t.integer "activity_log_tag_id"
  end

  create_table "activity_log_tags", force: :cascade do |t|
    t.string   "tag",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "activity_logs", force: :cascade do |t|
    t.string   "message",      limit: 255
    t.datetime "performed_at"
    t.integer  "level"
  end

  create_table "affiliation_assignments", force: :cascade do |t|
    t.integer  "affiliation_id"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "affiliations", force: :cascade do |t|
    t.string "name", limit: 255
  end

  add_index "affiliations", ["name"], name: "index_affiliations_on_name"

  create_table "api_key_users", force: :cascade do |t|
    t.string   "secret",       limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "name",         limit: 255
    t.datetime "logged_in_at"
  end

  add_index "api_key_users", ["name", "secret"], name: "index_api_key_users_on_name_and_secret"

  create_table "api_whitelisted_ip_users", force: :cascade do |t|
    t.string   "address",      limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "reason"
    t.datetime "logged_in_at"
  end

  add_index "api_whitelisted_ip_users", ["address"], name: "index_api_whitelisted_ip_users_on_address"

  create_table "application_operatorships", force: :cascade do |t|
    t.integer  "application_id"
    t.integer  "entity_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "parent_id"
  end

  add_index "application_operatorships", ["application_id", "entity_id", "parent_id"], name: "idx_app_operatorships_on_app_id_and_entity_id_and_parent_id"

  create_table "application_ou_assignments", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "application_id"
    t.integer  "ou_id"
  end

  create_table "application_ownerships", force: :cascade do |t|
    t.integer  "entity_id"
    t.integer  "application_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "parent_id"
  end

  create_table "applications", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "url",         limit: 255
  end

  add_index "applications", ["name"], name: "index_applications_on_name"

  create_table "classifications", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "classifications", ["name"], name: "index_classifications_on_name"

  create_table "classifications_titles", force: :cascade do |t|
    t.integer "classification_id"
    t.integer "title_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",               default: 0
    t.integer  "attempts",               default: 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "entities", force: :cascade do |t|
    t.string   "type",         limit: 255
    t.string   "name",         limit: 255
    t.string   "first",        limit: 255
    t.string   "last",         limit: 255
    t.string   "email",        limit: 255
    t.string   "loginid",      limit: 255
    t.boolean  "active",                   default: true
    t.string   "phone",        limit: 255
    t.string   "address",      limit: 255
    t.integer  "title_id"
    t.integer  "major_id"
    t.text     "description"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.datetime "logged_in_at"
  end

  add_index "entities", ["id"], name: "index_entities_on_id"
  add_index "entities", ["loginid"], name: "index_entities_on_loginid"
  add_index "entities", ["name"], name: "index_entities_on_name"
  add_index "entities", ["type"], name: "index_entities_on_type"

  create_table "group_group", id: false, force: :cascade do |t|
    t.integer "group_id"
    t.integer "subgroup_id"
  end

  create_table "group_memberships", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "entity_id"
    t.boolean  "calculated", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_operatorships", force: :cascade do |t|
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "entity_id"
    t.integer  "parent_id"
  end

  add_index "group_operatorships", ["group_id", "entity_id", "parent_id"], name: "idx_group_opships_on_g_id_and_entity_id_and_parent_id"

  create_table "group_owner_assignments", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_ownerships", force: :cascade do |t|
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entity_id"
    t.integer  "parent_id"
  end

  add_index "group_ownerships", ["group_id", "entity_id", "parent_id"], name: "idx_group_ownships_on_g_id_and_entity_id_and_parent_id"

  create_table "group_rule_results", force: :cascade do |t|
    t.integer  "group_rule_id"
    t.integer  "entity_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "group_rules", force: :cascade do |t|
    t.string   "column",     limit: 255
    t.string   "condition",  limit: 255
    t.string   "value",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "min_size"
    t.integer  "max_size"
    t.integer  "head_id"
    t.integer  "role_id"
  end

  create_table "groups_people", id: false, force: :cascade do |t|
    t.integer "group_id"
    t.integer "person_id"
  end

  create_table "majors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "majors", ["name"], name: "index_majors_on_name"

  create_table "organization_entity_associations", force: :cascade do |t|
    t.integer  "organization_id"
    t.integer  "entity_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "title_id"
  end

  create_table "organization_managers", force: :cascade do |t|
    t.integer  "organization_id"
    t.integer  "manager_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "organization_managers", ["manager_id"], name: "index_organization_managers_on_manager_id"
  add_index "organization_managers", ["organization_id"], name: "index_organization_managers_on_organization_id"

  create_table "organization_org_ids", force: :cascade do |t|
    t.integer  "organization_id"
    t.string   "org_id",          limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "organization_org_ids", ["org_id"], name: "index_organization_org_ids_on_org_id"
  add_index "organization_org_ids", ["organization_id"], name: "index_organization_org_ids_on_organization_id"

  create_table "organization_parent_ids", force: :cascade do |t|
    t.integer  "organization_id"
    t.integer  "parent_org_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "organization_parent_ids", ["organization_id"], name: "index_organization_parent_ids_on_organization_id"
  add_index "organization_parent_ids", ["parent_org_id"], name: "index_organization_parent_ids_on_parent_org_id"

  create_table "organizations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "dept_code",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "organizations", ["dept_code"], name: "index_organizations_on_dept_code"

  create_table "ou_assignments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "person_id"
    t.integer  "ou_id"
  end

  create_table "ou_children_assignments", force: :cascade do |t|
    t.integer "ou_id"
    t.integer "child_id"
  end

  create_table "ou_manager_assignments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "ou_id"
    t.integer  "manager_id"
  end

  create_table "ou_ou_assignments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ous", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "code",       limit: 255
  end

  create_table "people", force: :cascade do |t|
    t.string   "first",          limit: 255
    t.string   "last",           limit: 255
    t.string   "email",          limit: 255
    t.string   "loginid",        limit: 255
    t.string   "preferred_name", limit: 255
    t.boolean  "status"
    t.string   "phone",          limit: 255
    t.string   "address",        limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "title_id"
  end

  create_table "person_favorite_assignments", force: :cascade do |t|
    t.integer  "entity_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "person_manager_assignments", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "manager_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "role_assignments", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
    t.integer  "entity_id"
    t.integer  "parent_id"
  end

  add_index "role_assignments", ["role_id", "entity_id", "parent_id"], name: "index_role_assignments_on_role_id_and_entity_id_and_parent_id"
  add_index "role_assignments", ["role_id", "entity_id"], name: "index_role_assignments_on_role_id_and_entity_id"

  create_table "roles", force: :cascade do |t|
    t.string   "token",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "application_id"
    t.string   "name",           limit: 255
    t.string   "description",    limit: 255
    t.string   "ad_path",        limit: 255
    t.datetime "last_ad_sync"
    t.string   "ad_guid",        limit: 255
  end

  add_index "roles", ["id"], name: "index_roles_on_id"

  create_table "student_levels", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "students", force: :cascade do |t|
    t.integer  "level_id"
    t.integer  "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "titles", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "code", limit: 255
  end

  add_index "titles", ["code"], name: "index_titles_on_code"

  create_table "versions", force: :cascade do |t|
    t.integer  "versioned_id"
    t.string   "versioned_type", limit: 255
    t.integer  "user_id"
    t.string   "user_type",      limit: 255
    t.string   "user_name",      limit: 255
    t.text     "modifications"
    t.integer  "number"
    t.integer  "reverted_from"
    t.string   "tag",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "versions", ["created_at"], name: "index_versions_on_created_at"
  add_index "versions", ["number"], name: "index_versions_on_number"
  add_index "versions", ["tag"], name: "index_versions_on_tag"
  add_index "versions", ["user_id", "user_type"], name: "index_versions_on_user_id_and_user_type"
  add_index "versions", ["user_name"], name: "index_versions_on_user_name"
  add_index "versions", ["versioned_id", "versioned_type"], name: "index_versions_on_versioned_id_and_versioned_type"

end
