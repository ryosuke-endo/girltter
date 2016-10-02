class AddDescriptionToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :description, :string, null: false, after: :name
 end
end
