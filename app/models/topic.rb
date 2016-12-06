class Topic < ActiveRecord::Base
  has_attached_file :thumbnail, styles: { medium: '300x300>', thumb: '140x140>' }
  belongs_to :category

  validates :title, presence: true
  validates :body, presence: true
  validates_attachment :thumbnail,
                       content_type: { content_type: ['image/jpg',
                                                      'image/jpeg',
                                                      'image/png',
                                                      'image/gif'] }
end
