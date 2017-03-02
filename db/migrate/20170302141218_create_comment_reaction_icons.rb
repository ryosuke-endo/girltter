class CreateCommentReactionIcons < ActiveRecord::Migration
  def change
    create_table :comment_reaction_icons do |t|
      t.references :comment, index: true, foreign_key: true
      t.references :reaction_icon, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
