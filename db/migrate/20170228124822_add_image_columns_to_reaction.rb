class AddImageColumnsToReaction < ActiveRecord::Migration
  def up
    add_attachment :reactions, :image, after: :id
  end

  def down
    remove__attachment :reactions, :image
  end
end
