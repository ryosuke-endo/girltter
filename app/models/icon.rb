class Icon < ActiveRecord::Base
  has_many :reactions, as: :reactionable
  has_attached_file :image

  validates_attachment :image,
                       content_type: { content_type: ['image/jpg',
                                                      'image/jpeg',
                                                      'image/png',
                                                      'image/gif'] }

  def style_class
    "emoji-#{image_file_name.gsub(/(unicode\/|\.png)/, '')}"
  end
end
