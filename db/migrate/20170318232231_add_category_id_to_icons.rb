class AddCategoryIdToIcons < ActiveRecord::Migration
  def change
    add_reference :icons, :icon_category, index: true, foreign_key: true, after: :id
  end
end
