class AddTopicIdToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :topic, index: true, foreign_key: true, null: false, after: :body
  end
end
