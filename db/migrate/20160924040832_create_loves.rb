class CreateLoves < ActiveRecord::Migration
  def change
    create_table :loves do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.integer :user, index: true, null: false

      t.timestamps null: false
    end
  end
end
