class AddCoulumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :sex, :integer, default: 0, null: false
  end
end
