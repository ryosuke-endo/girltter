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

ActiveRecord::Schema.define(version: 20170327224132) do

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.string   "name",                           null: false
    t.string   "description",                    null: false
    t.integer  "position",           default: 0, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",                null: false
    t.string   "image_content_type",             null: false
    t.integer  "image_file_size",                null: false
    t.datetime "image_updated_at",               null: false
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.text     "body",               limit: 65535, null: false
    t.string   "name",                             null: false
    t.integer  "topic_id",                         null: false
    t.datetime "image_updated_at"
    t.integer  "image_file_size"
    t.string   "image_content_type"
    t.string   "image_file_name"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["topic_id"], name: "index_comments_on_topic_id", using: :btree
  end

  create_table "icon_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "icons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.integer  "icon_category_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["icon_category_id"], name: "index_icons_on_icon_category_id", using: :btree
  end

  create_table "reactions", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.integer  "icon_id",           null: false
    t.integer  "reactionable_id",   null: false
    t.string   "reactionable_type", null: false
    t.string   "user_cookie_value", null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["icon_id"], name: "index_reactions_on_icon_id", using: :btree
    t.index ["reactionable_id", "reactionable_type"], name: "index_reactions_on_reactionable_id_and_reactionable_type", using: :btree
    t.index ["user_cookie_value", "icon_id", "reactionable_id", "reactionable_type"], name: "index_reactions_on_uniq_cookie_and_ids", unique: true, using: :btree
  end

  create_table "reads", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.integer "readable_id",                null: false
    t.string  "readable_type",              null: false
    t.integer "read_count",     default: 0, null: false
    t.date    "recording_date",             null: false
    t.index ["readable_id", "readable_type"], name: "index_reads_on_readable_id_and_readable_type", using: :btree
  end

  create_table "taggings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "topics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.string   "title",                                null: false
    t.text     "body",                   limit: 65535, null: false
    t.string   "name",                                 null: false
    t.integer  "category_id",                          null: false
    t.datetime "thumbnail_updated_at"
    t.integer  "thumbnail_file_size"
    t.string   "thumbnail_content_type"
    t.string   "thumbnail_file_name"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["category_id"], name: "index_topics_on_category_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.string   "email",                        null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "type",                         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login",                        null: false
    t.string   "name",                         null: false
    t.integer  "sex",              default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["login"], name: "index_users_on_login", unique: true, using: :btree
    t.index ["type"], name: "index_users_on_type", using: :btree
  end

  add_foreign_key "comments", "topics"
  add_foreign_key "icons", "icon_categories"
  add_foreign_key "reactions", "icons"
  add_foreign_key "topics", "categories"
end
