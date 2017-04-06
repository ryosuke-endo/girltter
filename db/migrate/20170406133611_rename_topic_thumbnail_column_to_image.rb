class RenameTopicThumbnailColumnToImage < ActiveRecord::Migration[5.0]
  def up
    rename_column :topics, :thumbnail_updated_at, :image_updated_at
    rename_column :topics, :thumbnail_file_size, :image_file_size
    rename_column :topics, :thumbnail_content_type, :image_content_type
    rename_column :topics, :thumbnail_file_name, :image_file_name
  end
end
