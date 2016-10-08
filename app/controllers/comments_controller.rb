class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
    else
    end
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body,
                                    :commentable_id,
                                    :commentable_type,
                                    :member_id)
  end
end
