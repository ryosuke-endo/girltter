class CommentsController < ApplicationController
  skip_before_action :require_login

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to
    else
      redirect_to @comment.topic
    end
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body,
                                    :name,
                                    :topic_id)
  end
end
