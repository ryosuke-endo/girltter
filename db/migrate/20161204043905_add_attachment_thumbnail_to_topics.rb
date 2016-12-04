class AddAttachmentThumbnailToTopics < ActiveRecord::Migration
  def self.up
    change_table :topics do |t|
      t.attachment :thumbnail, after: :category_id
    end
  end

  def self.down
    remove_attachment :topics, :thumbnail
  end
end
