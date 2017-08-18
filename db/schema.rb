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

  create_table "activity_log_tag_associations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "activity_log_id"
    t.integer "activity_log_tag_id"
  end

  create_table "activity_log_tags", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "activity_logs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "message"
    t.datetime "performed_at"
    t.integer "level"
  end

  create_table "affiliation_assignments", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "affiliation_id"
    t.integer "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "affiliations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.index ["name"], name: "index_affiliations_on_name"
  end

  create_table "api_key_users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.datetime "logged_in_at"
    t.index ["name", "secret"], name: "index_api_key_users_on_name_and_secret"
  end

  create_table "api_whitelisted_ip_users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "reason"
    t.datetime "logged_in_at"
    t.index ["address"], name: "index_api_whitelisted_ip_users_on_address"
  end

  create_table "application_operatorships", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "application_id"
    t.integer "entity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_id"
    t.index ["application_id", "entity_id", "parent_id"], name: "idx_app_operatorships_on_app_id_and_entity_id_and_parent_id"
  end

  create_table "application_ownerships", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "entity_id"
    t.integer "application_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_id"
  end

  create_table "applications", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "url"
    t.index ["name"], name: "index_applications_on_name"
  end

  create_table "classifications", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_classifications_on_name"
  end

  create_table "classifications_titles", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "classification_id"
    t.integer "title_id"
  end

  create_table "delayed_jobs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "priority", default: 0
    t.integer "attempts", default: 0
    t.text "handler"
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "entities", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "type"
    t.string "name"
    t.string "first"
    t.string "last"
    t.string "email"
    t.string "loginid"
    t.boolean "active", default: true
    t.string "phone"
    t.string "address"
    t.integer "title_id"
    t.integer "major_id"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "logged_in_at"
    t.index ["id"], name: "index_entities_on_id"
    t.index ["loginid"], name: "index_entities_on_loginid"
    t.index ["name"], name: "index_entities_on_name"
    t.index ["type"], name: "index_entities_on_type"
  end

  create_table "group_memberships", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "group_id"
    t.integer "entity_id"
    t.boolean "calculated", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_operatorships", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "entity_id"
  end

  create_table "group_ownerships", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "entity_id"
  end

  create_table "group_rule_results", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "group_rule_id"
    t.integer "entity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_rules", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "column"
    t.string "condition"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "group_id"
  end

  create_table "majors", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_majors_on_name"
  end

  create_table "organization_entity_associations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "organization_id"
    t.integer "entity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "title_id"
  end

  create_table "organization_managers", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "organization_id"
    t.integer "manager_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manager_id"], name: "index_organization_managers_on_manager_id"
    t.index ["organization_id"], name: "index_organization_managers_on_organization_id"
  end

  create_table "organization_org_ids", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "organization_id"
    t.string "org_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["org_id"], name: "index_organization_org_ids_on_org_id"
    t.index ["organization_id"], name: "index_organization_org_ids_on_organization_id"
  end

  create_table "organization_parent_ids", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "organization_id"
    t.integer "parent_org_id", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_organization_parent_ids_on_organization_id"
    t.index ["parent_org_id"], name: "index_organization_parent_ids_on_parent_org_id"
  end

  create_table "organizations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "dept_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dept_code"], name: "index_organizations_on_dept_code"
  end

  create_table "person_favorite_assignments", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "entity_id"
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "role_assignments", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role_id"
    t.integer "entity_id"
    t.integer "parent_id"
    t.index ["role_id", "entity_id", "parent_id"], name: "index_role_assignments_on_role_id_and_entity_id_and_parent_id"
    t.index ["role_id", "entity_id"], name: "index_role_assignments_on_role_id_and_entity_id"
  end

  create_table "roles", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "application_id"
    t.string "name"
    t.string "description"
    t.string "ad_path"
    t.datetime "last_ad_sync"
    t.string "ad_guid"
    t.index ["id"], name: "index_roles_on_id"
  end

  create_table "student_levels", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "level_id"
    t.integer "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "titles", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "code"
    t.index ["code"], name: "index_titles_on_code"
  end

  create_table "versions", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "versioned_id"
    t.string "versioned_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "user_name"
    t.text "modifications"
    t.integer "number"
    t.integer "reverted_from"
    t.string "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_versions_on_created_at"
    t.index ["number"], name: "index_versions_on_number"
    t.index ["tag"], name: "index_versions_on_tag"
    t.index ["user_id", "user_type"], name: "index_versions_on_user_id_and_user_type"
    t.index ["user_name"], name: "index_versions_on_user_name"
    t.index ["versioned_id", "versioned_type"], name: "index_versions_on_versioned_id_and_versioned_type"
  end

end
