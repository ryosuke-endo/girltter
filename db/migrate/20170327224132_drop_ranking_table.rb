class DropRankingTable < ActiveRecord::Migration[5.0]
  def up
    drop_table :rankings if table_exists?(:rankings)
  end

  def down
    create_table "rankings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
      t.integer  "rankable_id",               null: false
      t.string   "rankable_type",             null: false
      t.integer  "read_count",    default: 0, null: false
      t.date     "start_date",                null: false
      t.datetime "created_at",                null: false
      t.datetime "updated_at",                null: false
      t.index ["rankable_id", "rankable_type"], name: "index_rankings_on_rankable_id_and_rankable_type", using: :btree
    end
  end
end
