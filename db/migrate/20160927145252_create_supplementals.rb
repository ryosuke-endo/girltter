class CreateSupplementals < ActiveRecord::Migration
  def change
    create_table :supplementals do |t|
      t.text :body, null: false
      t.integer :supplementable_id, null: false
      t.string :supplementable_type, null: false

      t.timestamps null: false
    end
    add_index :supplementals, [:supplementable_id, :supplementable_type]
  end
end
