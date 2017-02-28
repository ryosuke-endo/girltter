class CommentReaction < ActiveRecord::Base
  belongs_to :comment
  belongs_to :reaction
end
