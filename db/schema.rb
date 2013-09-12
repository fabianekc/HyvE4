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

ActiveRecord::Schema.define(:version => 20130912104227) do

  create_table "datavals", :force => true do |t|
    t.string   "value"
    t.integer  "structure_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.datetime "valdatime"
    t.text     "comment"
  end

  add_index "datavals", ["structure_id", "created_at"], :name => "index_datavals_on_structure_id_and_created_at"

  create_table "group_items", :force => true do |t|
    t.string   "groupid"
    t.string   "groupname"
    t.string   "itemname"
    t.integer  "itemtype"
    t.string   "lang"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "comment"
  end

  add_index "groups", ["project_id"], :name => "index_groups_on_project_id"

  create_table "invites", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "bio"
    t.text     "reason"
    t.boolean  "process"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "rtype"
  end

  create_table "pjattribs", :force => true do |t|
    t.integer  "project_id"
    t.integer  "attrtype"
    t.string   "attrvalue"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "pjattribs", ["project_id"], :name => "index_pjattribs_on_project_id"

  create_table "postings", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "postings", ["user_id", "created_at"], :name => "index_postings_on_user_id_and_created_at"

  create_table "projects", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.text     "wissen"
    t.text     "tun"
    t.text     "hoffen"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.boolean  "emaildata"
    t.datetime "nextmail"
  end

  add_index "projects", ["user_id"], :name => "index_projects_on_user_id"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "structures", :force => true do |t|
    t.string   "name"
    t.integer  "group_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.text     "comment"
    t.integer  "fieldtype"
    t.datetime "lastmailsent"
  end

  add_index "structures", ["group_id"], :name => "index_structures_on_group_id"

  create_table "template_groups", :force => true do |t|
    t.string   "templateid"
    t.string   "templatename"
    t.string   "groupname"
    t.string   "lang"
    t.text     "description"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",                  :default => false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "password_confirmation"
    t.string   "invitecode"
    t.text     "bio"
    t.datetime "lastlogin"
    t.integer  "logincnt",               :default => 1
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
