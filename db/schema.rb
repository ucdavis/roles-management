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

ActiveRecord::Schema.define(:version => 20130315200349) do

  create_table "affiliation_assignments", :force => true do |t|
    t.integer  "affiliation_id"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "affiliations", :force => true do |t|
    t.string "name"
  end

  create_table "api_key_users", :force => true do |t|
    t.string   "secret"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
  end

  create_table "api_whitelisted_ip_users", :force => true do |t|
    t.string   "address"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "reason"
  end

  create_table "application_operator_assignments", :force => true do |t|
    t.integer  "application_id"
    t.integer  "entity_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "application_owner_assignments", :force => true do |t|
    t.integer  "owner_id"
    t.integer  "application_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "applications", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "hostname"
    t.text     "description"
    t.integer  "api_key_id"
  end

  create_table "classifications", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.boolean  "status"
    t.string   "phone"
    t.string   "address"
    t.integer  "title_id"
    t.integer  "major_id"
    t.string   "code"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "entities_groups", :id => false, :force => true do |t|
    t.integer "group_id"
    t.integer "entity_id"
  end

  create_table "group_operator_assignments", :force => true do |t|
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "entity_id"
  end

  create_table "group_owner_assignments", :force => true do |t|
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entity_id"
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

  create_table "person_favorite_assignments", :force => true do |t|
    t.integer  "person_id"
    t.integer  "favorite_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "role_assignments", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
    t.integer  "entity_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "application_id"
    t.string   "name"
    t.string   "description"
    t.boolean  "mandatory"
    t.string   "ad_path"
    t.datetime "last_ad_sync"
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
