class AddNameToComments < ActiveRecord::Migration
  def change
    add_column :comments, :name, :string, null: false, after: :body
  end
end
