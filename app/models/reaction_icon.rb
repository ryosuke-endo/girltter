class ReactionIcon < ActiveRecord::Base
  has_attached_file :image
  has_many :comment_reaction_icons
  has_many :comments, through: :comment_reaction_icons

  validates_attachment :image,
                       content_type: { content_type: ['image/jpg',
                                                      'image/jpeg',
                                                      'image/png',
                                                      'image/gif'] }
end
