class AddAttachmentImageToCategories < ActiveRecord::Migration
  def self.up
    change_table :categories do |t|
      t.attachment :image, null: false
    end
  end

  def self.down
    remove_attachment :categories, :image
  end
end
