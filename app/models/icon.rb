class Icon < ActiveRecord::Base
  has_many :reactions, as: :reactionable
  belongs_to :category, class_name: 'IconCategory', foreign_key: :icon_category_id
  has_attached_file :image

  validates_attachment :image,
                       content_type: { content_type: ['image/jpg',
                                                      'image/jpeg',
                                                      'image/png',
                                                      'image/gif'] }

  def style_class
    "emoji-#{image_file_name.gsub(/(unicode\/|\.png)/, '')}"
  end

  def self.find_by_hexname(name)
    name << '.png'
    find_by(image_file_name: name)
  end
end
