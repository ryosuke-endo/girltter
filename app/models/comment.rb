class Comment < ActiveRecord::Base
  has_attached_file :image,
    styles: { normal: '500x500>',
              thumbnail: '140x140>' }

  belongs_to :topic

  validates :body, presence: true
  validates :name, presence: true
  validates_attachment :image,
    content_type: { content_type: ['image/jpg',
                                   'image/jpeg',
                                   'image/png',
                                   'image/gif',
                                   'image/bmp'] },
    less_than: 20.megabytes
end
