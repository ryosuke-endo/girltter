class CreateReactionIcons < ActiveRecord::Migration
  def change
    create_table :reaction_icons do |t|
      t.attachment :image
      t.timestamps null: false
    end
  end
end
