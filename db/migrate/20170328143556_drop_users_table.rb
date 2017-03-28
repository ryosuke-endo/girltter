class DropUsersTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :users if table_exists?(:users)
  end

  def down
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
  end
end
