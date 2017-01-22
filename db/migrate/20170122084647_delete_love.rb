class DeleteLove < ActiveRecord::Migration
  def change
    drop_table :loves
  end
end
