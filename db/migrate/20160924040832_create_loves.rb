class CreateLoves < ActiveRecord::Migration
  def change
    create_table :loves do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.references :user, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
