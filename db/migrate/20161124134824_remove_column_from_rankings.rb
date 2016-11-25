class RemoveColumnFromRankings < ActiveRecord::Migration
  def change
    remove_column :rankings, :type, :string
  end
end
