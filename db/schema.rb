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

ActiveRecord::Schema.define(:version => 20120328191703) do

  create_table "affiliation_assignments", :force => true do |t|
    t.integer  "affiliation_id"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "affiliations", :force => true do |t|
    t.string "name"
  end

  create_table "application_manager_assignments", :force => true do |t|
    t.integer  "manager_id"
    t.integer  "application_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "application_ou_assignments", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "application_id"
    t.integer  "ou_id"
  end

  create_table "applications", :force => true do |t|
    t.string   "name"
    t.string   "api_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "hostname"
    t.string   "display_name"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.text     "description"
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

  create_table "group_group", :id => false, :force => true do |t|
    t.integer "group_id"
    t.integer "subgroup_id"
  end

  create_table "group_owner_assignments", :force => true do |t|
    t.integer  "group_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_rules", :force => true do |t|
    t.string   "column"
    t.string   "condition"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "min_size"
    t.integer  "max_size"
    t.text     "description"
  end

  create_table "groups_people", :id => false, :force => true do |t|
    t.integer "group_id"
    t.integer "person_id"
  end

  create_table "ou_assignments", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id"
    t.integer  "ou_id"
  end

  create_table "ou_children_assignments", :force => true do |t|
    t.integer "ou_id"
    t.integer "child_id"
  end

  create_table "ou_manager_assignments", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ou_id"
    t.integer  "manager_id"
  end

  create_table "ou_ou_assignments", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ous", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  create_table "people", :force => true do |t|
    t.string   "first"
    t.string   "last"
    t.string   "email"
    t.string   "loginid"
    t.string   "preferred_name"
    t.boolean  "status"
    t.string   "phone"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "title_id"
  end

  create_table "person_manager_assignments", :force => true do |t|
    t.integer  "person_id"
    t.integer  "manager_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "role_assignments", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id"
    t.integer  "role_id"
    t.integer  "group_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "application_id"
    t.boolean  "default",        :default => false
    t.string   "descriptor"
    t.string   "description"
    t.boolean  "mandatory"
    t.string   "ad_path"
  end

  create_table "template_assignments", :force => true do |t|
    t.integer "template_id"
    t.integer "person_id"
    t.integer "group_id"
  end

  create_table "template_rules", :force => true do |t|
    t.string   "condition"
    t.string   "value"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "template_id"
  end

  create_table "templates", :force => true do |t|
    t.string "name"
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
