class AddCategoryIdToLoves < ActiveRecord::Migration
  def change
    add_column :loves, :category_id, :integer, null: false, after: :user_id
    add_index :loves, :category_id
  end
end
