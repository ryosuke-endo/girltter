class CreateReactions < ActiveRecord::Migration
  def change
    create_table :reactions do |t|
      t.references :icon, index: true, foreign_key: true, null: false
      t.integer :reactionable_id, null: false
      t.string :reactionable_type, null: false

      t.timestamps null: false
    end

    add_index :reactions, [:reactionable_id, :reactionable_type]
  end
end
