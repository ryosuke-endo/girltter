class Api::Topics::CommentsController < ApplicationController
  skip_before_action :require_login

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render json: @comment, status: 200
    else
      render json: { errors: @comment.errors,
                     error_messages: @comment.errors.full_messages },
             status: 422
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body,
                                    :name,
                                    :image,
                                    :topic_id)
  end
end
