class CreateLoves < ActiveRecord::Migration
  def change
    create_table :loves do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.integer :member_id, index: true, null: false

      t.timestamps null: false
    end
  end
end
