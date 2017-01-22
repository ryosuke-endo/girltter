class Topics::CommentsController < Topics::ApplicationController
  before_action :set_tag_ranking

  def create
    @comment = Comment.new(comment_params)
    @topic = @comment.topic
    if @comment.save
      redirect_to @topic
    else
      render 'topics/show'
    end
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body,
                                    :image,
                                    :name,
                                    :topic_id)
  end

  def set_tag_ranking
    @tag_ranking = ActsAsTaggableOn::Tag.most_used
  end
end
