class DropReadsTable < ActiveRecord::Migration[5.0]
  def up
    drop_table :reads if table_exists?(:reads)
  end

  def down
    create_table "reads", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
      t.integer "readable_id",                null: false
      t.string  "readable_type",              null: false
      t.integer "read_count",     default: 0, null: false
      t.date    "recording_date",             null: false
      t.index ["readable_id", "readable_type"], name: "index_reads_on_readable_id_and_readable_type", using: :btree
    end
  end
end
