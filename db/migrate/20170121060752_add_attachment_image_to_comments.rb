class AddAttachmentImageToComments < ActiveRecord::Migration
  def self.up
    change_table :comments do |t|
      t.attachment :image, after: :topic_id
    end
  end

  def self.down
    remove_attachment :comments, :image
  end
end
