class Category < ActiveRecord::Base
  has_attached_file :image, styles: { medium: '300x300>', thumb: '140x140>' }
  has_many :topics, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates_attachment :image,
                       content_type: { content_type: ['image/jpg',
                                                      'image/jpeg',
                                                      'image/png',
                                                      'image/gif'] }

  scope :ordered_position, -> { order(position: :asc) }
end
