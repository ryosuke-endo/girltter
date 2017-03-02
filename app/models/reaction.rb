class Reaction < ActiveRecord::Base
  has_attached_file :image
  has_many :comment_reactions
  has_many :comments, through: :comment_reactions

  validates_attachment :image,
                       content_type: { content_type: ['image/jpg',
                                                      'image/jpeg',
                                                      'image/png',
                                                      'image/gif'] }

end
