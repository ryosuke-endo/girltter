class DeleteColumnComment < ActiveRecord::Migration
  def change
    remove_column :comments, :member_id, :integer
    remove_column :comments, :commentable_id, :integer
    remove_column :comments, :commentable_type, :string
  end
end
