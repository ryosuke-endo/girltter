class CreateIconCategories < ActiveRecord::Migration
  def change
    create_table :icon_categories do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
