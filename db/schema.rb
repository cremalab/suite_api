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

ActiveRecord::Schema.define(version: 20131010162243) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: true do |t|
    t.string   "access_token"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.text     "content"
    t.integer  "idea_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["idea_id"], name: "index_comments_on_idea_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
  end

  add_index "groups", ["owner_id"], name: "index_groups_on_owner_id", using: :btree

  create_table "idea_threads", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "status"
    t.text     "description"
    t.datetime "expiration"
  end

  add_index "idea_threads", ["user_id"], name: "index_idea_threads_on_user_id", using: :btree

  create_table "ideas", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "idea_thread_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ideas", ["idea_thread_id"], name: "index_ideas_on_idea_thread_id", using: :btree
  add_index "ideas", ["user_id"], name: "index_ideas_on_user_id", using: :btree

  create_table "memberships", force: true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["group_id"], name: "index_memberships_on_group_id", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "profiles", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "avatar"
    t.string   "position"
    t.text     "biography"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                                        null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.boolean  "notifications",                default: false
  end

  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree

  create_table "votes", force: true do |t|
    t.integer  "user_id"
    t.integer  "idea_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["idea_id"], name: "index_votes_on_idea_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

  create_table "voting_rights", force: true do |t|
    t.integer  "user_id"
    t.integer  "idea_thread_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
