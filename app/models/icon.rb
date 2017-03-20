class Icon < ActiveRecord::Base
  has_many :reactions, as: :reactionable
  belongs_to :category, class_name: 'IconCategory', foreign_key: :icon_category_id
  has_attached_file :image

  validates_attachment :image,
                       content_type: { content_type: ['image/jpg',
                                                      'image/jpeg',
                                                      'image/png',
                                                      'image/gif'] }
end
