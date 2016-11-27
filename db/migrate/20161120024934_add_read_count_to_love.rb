class AddReadCountToLove < ActiveRecord::Migration
  def change
    add_column :loves, :read_count, :integer, null: false, default: 0, after: :category_id
  end
end
