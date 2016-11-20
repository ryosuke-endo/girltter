class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.string :type, null: false
      t.integer :rankable_id, null: false
      t.string :rankable_type, null: false
      t.integer :read_count, null: false
      t.datetime :start_on, null: false

      t.timestamps null: false
    end
    add_index :rankings, [:rankable_id, :rankable_type]
  end
end
