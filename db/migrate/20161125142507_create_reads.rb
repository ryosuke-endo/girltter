class CreateReads < ActiveRecord::Migration
  def change
    create_table :reads do |t|
      t.integer :readable_id, null: false
      t.string :readable_type, null: false
      t.integer :read_count, null: false, default: 0
      t.date :recording_date, null: false
    end
    add_index :reads, [:readable_id, :readable_type]
  end
end
