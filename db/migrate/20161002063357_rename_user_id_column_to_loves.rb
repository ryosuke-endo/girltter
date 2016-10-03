class RenameUserIdColumnToLoves < ActiveRecord::Migration
  def change
    rename_column :loves, :user_id, :member_id
  end
end
