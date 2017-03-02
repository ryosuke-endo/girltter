class CommentReactionIcon < ActiveRecord::Base
  belongs_to :comment
  belongs_to :reaction_icon
end
