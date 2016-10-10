class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      content = render_to_string partial: 'comment',
                                 locals: { comment: @comment,
                                           thread: @comment.commentable }
      render text: content
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
