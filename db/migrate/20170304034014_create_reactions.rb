class CreateReactions < ActiveRecord::Migration
  def change
    create_table :reactions do |t|
      t.references :icon, index: true, foreign_key: true, null: false
      t.integer :reactionable_id, null: false
      t.string :reactionable_type, null: false
      t.string :user_cookie_value, null: false

      t.timestamps null: false
    end

    add_index :reactions, [:reactionable_id, :reactionable_type]
    add_index :reactions,
      [:user_cookie_value, :icon_id, :reactionable_id, :reactionable_type],
      unique: true,
      name: :index_reactions_on_uniq_cookie_and_ids
  end
end
