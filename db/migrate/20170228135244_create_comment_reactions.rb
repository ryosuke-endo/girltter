class CreateCommentReactions < ActiveRecord::Migration
  def change
    create_table :comment_reactions do |t|
      t.references :comment, index: true, foreign_key: true, null: false
      t.references :reaction, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
