class DeleteSupplemental < ActiveRecord::Migration
  def change
    drop_table :supplementals
  end
end
