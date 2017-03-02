class TopicsController < ApplicationController
  layout 'one_column'
  skip_before_action :require_login

  before_action :set_category, only: :new
  before_action :set_tag_ranking, only: :show
  before_action :set_topic, only: :show

  def new
  end

  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      redirect_to complete_topics_url(id: @topic)
    else
      render :new
    end
  end

  def complete
  end

  def show
    @count_map = @topic.comment_reactions_count_map
    render layout: 'topic'
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_tag_ranking
    @tag_ranking = ActsAsTaggableOn::Tag.most_used
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:title,
                                  :body,
                                  :category_id,
                                  :name,
                                  :thumbnail)
  end
end
