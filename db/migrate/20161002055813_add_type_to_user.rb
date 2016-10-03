class AddTypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :type, :string, null: false, after: :salt
    add_index :users, :type
  end
end
