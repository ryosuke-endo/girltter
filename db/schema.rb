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

ActiveRecord::Schema.define(version: 20161028080711) do

  create_table "categories", force: :cascade do |t|
    t.string   "name",        limit: 255, null: false
    t.string   "description", limit: 255, null: false
    t.string   "type",        limit: 255, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "categories", ["type"], name: "index_categories_on_type", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "body",             limit: 65535, null: false
    t.integer  "member_id",        limit: 4,     null: false
    t.integer  "commentable_id",   limit: 4,     null: false
    t.string   "commentable_type", limit: 255,   null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["member_id"], name: "index_comments_on_member_id", using: :btree

  create_table "loves", force: :cascade do |t|
    t.string   "title",       limit: 255,   null: false
    t.text     "body",        limit: 65535, null: false
    t.integer  "member_id",   limit: 4,     null: false
    t.integer  "category_id", limit: 4,     null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "loves", ["category_id"], name: "index_loves_on_category_id", using: :btree
  add_index "loves", ["member_id"], name: "index_loves_on_member_id", using: :btree

  create_table "supplementals", force: :cascade do |t|
    t.text     "body",                limit: 65535, null: false
    t.integer  "supplementable_id",   limit: 4,     null: false
    t.string   "supplementable_type", limit: 255,   null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "supplementals", ["supplementable_id", "supplementable_type"], name: "index_supplementals_on_supplementable_id_and_supplementable_type", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["context"], name: "index_taggings_on_context", using: :btree
  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
  add_index "taggings", ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
  add_index "taggings", ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
  add_index "taggings", ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
  add_index "taggings", ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",            limit: 255,             null: false
    t.string   "crypted_password", limit: 255
    t.string   "salt",             limit: 255
    t.string   "type",             limit: 255,             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login",            limit: 255,             null: false
    t.string   "name",             limit: 255
    t.integer  "sex",              limit: 4,   default: 0, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["login"], name: "index_users_on_login", unique: true, using: :btree
  add_index "users", ["type"], name: "index_users_on_type", using: :btree

end
