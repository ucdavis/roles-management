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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140321005717) do

  create_table "activity_log_tag_associations", :force => true do |t|
    t.integer "activity_log_id"
    t.integer "activity_log_tag_id"
  end

  create_table "activity_log_tags", :force => true do |t|
    t.string   "tag"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "activity_logs", :force => true do |t|
    t.string   "message"
    t.datetime "performed_at"
    t.integer  "level"
  end

  create_table "affiliation_assignments", :force => true do |t|
    t.integer  "affiliation_id"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "affiliations", :force => true do |t|
    t.string "name"
  end

  add_index "affiliations", ["name"], :name => "index_affiliations_on_name"

  create_table "api_key_users", :force => true do |t|
    t.string   "secret"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "name"
    t.datetime "logged_in_at"
  end

  add_index "api_key_users", ["name", "secret"], :name => "index_api_key_users_on_name_and_secret"

  create_table "api_whitelisted_ip_users", :force => true do |t|
    t.string   "address"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.text     "reason"
    t.datetime "logged_in_at"
  end

  add_index "api_whitelisted_ip_users", ["address"], :name => "index_api_whitelisted_ip_users_on_address"

  create_table "application_operatorships", :force => true do |t|
    t.integer  "application_id"
    t.integer  "entity_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "parent_id"
  end

  add_index "application_operatorships", ["application_id", "entity_id", "parent_id"], :name => "idx_app_operatorships_on_app_id_and_entity_id_and_parent_id"

  create_table "application_ownerships", :force => true do |t|
    t.integer  "entity_id"
    t.integer  "application_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "parent_id"
  end

  create_table "applications", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "url"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
  end

  add_index "applications", ["name"], :name => "index_applications_on_name"

  create_table "classifications", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "classifications", ["name"], :name => "index_classifications_on_name"

  create_table "classifications_titles", :force => true do |t|
    t.integer "classification_id"
    t.integer "title_id"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "entities", :force => true do |t|
    t.string   "type"
    t.string   "name"
    t.string   "first"
    t.string   "last"
    t.string   "email"
    t.string   "loginid"
    t.boolean  "active",       :default => true
    t.string   "phone"
    t.string   "address"
    t.integer  "title_id"
    t.integer  "major_id"
    t.text     "description"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.datetime "logged_in_at"
    t.integer  "ou_id"
  end

  add_index "entities", ["loginid"], :name => "index_entities_on_loginid"
  add_index "entities", ["name"], :name => "index_entities_on_name"
  add_index "entities", ["ou_id"], :name => "index_entities_on_ou_id"

  create_table "group_memberships", :force => true do |t|
    t.integer  "group_id"
    t.integer  "entity_id"
    t.boolean  "calculated", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_operatorships", :force => true do |t|
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "entity_id"
    t.integer  "parent_id"
  end

  add_index "group_operatorships", ["group_id", "entity_id", "parent_id"], :name => "idx_group_opships_on_g_id_and_entity_id_and_parent_id"

  create_table "group_ownerships", :force => true do |t|
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entity_id"
    t.integer  "parent_id"
  end

  add_index "group_ownerships", ["group_id", "entity_id", "parent_id"], :name => "idx_group_ownships_on_g_id_and_entity_id_and_parent_id"

  create_table "group_rule_results", :force => true do |t|
    t.integer  "group_rule_id"
    t.integer  "entity_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "group_rules", :force => true do |t|
    t.string   "column"
    t.string   "condition"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
  end

  create_table "majors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "majors", ["name"], :name => "index_majors_on_name"

  create_table "organization_entity_associations", :force => true do |t|
    t.integer  "organization_id"
    t.integer  "entity_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "title_id"
  end

  create_table "organization_managers", :force => true do |t|
    t.integer  "organization_id"
    t.integer  "manager_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "organization_managers", ["manager_id"], :name => "index_organization_managers_on_manager_id"
  add_index "organization_managers", ["organization_id"], :name => "index_organization_managers_on_organization_id"

  create_table "organization_org_ids", :force => true do |t|
    t.integer  "organization_id"
    t.string   "org_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "organization_org_ids", ["org_id"], :name => "index_organization_org_ids_on_org_id"
  add_index "organization_org_ids", ["organization_id"], :name => "index_organization_org_ids_on_organization_id"

  create_table "organization_parent_ids", :force => true do |t|
    t.integer  "organization_id"
    t.integer  "parent_org_id",   :limit => 255
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "organization_parent_ids", ["organization_id"], :name => "index_organization_parent_ids_on_organization_id"
  add_index "organization_parent_ids", ["parent_org_id"], :name => "index_organization_parent_ids_on_parent_org_id"

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.string   "dept_code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "organizations", ["dept_code"], :name => "index_organizations_on_dept_code"

  create_table "person_favorite_assignments", :force => true do |t|
    t.integer  "entity_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "role_assignments", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
    t.integer  "entity_id"
    t.integer  "parent_id"
  end

  add_index "role_assignments", ["role_id", "entity_id", "parent_id"], :name => "index_role_assignments_on_role_id_and_entity_id_and_parent_id"
  add_index "role_assignments", ["role_id", "entity_id"], :name => "index_role_assignments_on_role_id_and_entity_id"

  create_table "roles", :force => true do |t|
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "application_id"
    t.string   "name"
    t.string   "description"
    t.string   "ad_path"
    t.datetime "last_ad_sync"
    t.string   "ad_guid"
  end

  create_table "student_levels", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "students", :force => true do |t|
    t.integer  "level_id"
    t.integer  "person_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "titles", :force => true do |t|
    t.string "name"
    t.string "code"
  end

  add_index "titles", ["code"], :name => "index_titles_on_code"

  create_table "versions", :force => true do |t|
    t.integer  "versioned_id"
    t.string   "versioned_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "user_name"
    t.text     "modifications"
    t.integer  "number"
    t.integer  "reverted_from"
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "versions", ["created_at"], :name => "index_versions_on_created_at"
  add_index "versions", ["number"], :name => "index_versions_on_number"
  add_index "versions", ["tag"], :name => "index_versions_on_tag"
  add_index "versions", ["user_id", "user_type"], :name => "index_versions_on_user_id_and_user_type"
  add_index "versions", ["user_name"], :name => "index_versions_on_user_name"
  add_index "versions", ["versioned_id", "versioned_type"], :name => "index_versions_on_versioned_id_and_versioned_type"

end
