class Category < ActiveRecord::Base
  has_attached_file :image, styles: { medium: '300x300>', thumb: '140x140>' }

  validates :name, presence: true
  validates :description, presence: true
  validates_attachment :image,
                       content_type: { content_type: ['image/jpg',
                                                      'image/jpeg',
                                                      'image/png',
                                                      'image/gif'] }
end
