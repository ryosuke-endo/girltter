class AddColumnToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :name, :string, null: false
  end
end
