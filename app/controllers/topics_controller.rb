class TopicsController < ApplicationController
  include Cookie
  before_action :set_category, only: :new
  before_action :set_tag_ranking, only: :show
  before_action :set_topic, only: :show

  def new
    if pc?
      render layout: 'one_column'
    end
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
    if pc?
      render layout: 'one_column'
    end
  end

  def search
    @tag_ranking = ActsAsTaggableOn::Tag.most_used
  end

  def show
    category = @topic.category
    @topics = category.topics.
              where.not(id: @topic.id).
              order(id: :desc).
              limit(3)
    render layout: 'topic'
  end

  def reaction_count_map
    @topic = Topic.find(params[:topic_id])
    map = { topic: {}, comment: {} }
    map[:topic] = @topic.icons.group_by(&:id)
    @topic.comments.includes(:icons).each do |comment|
      map[:comment][comment.id] = comment.icons.group_by(&:id)
    end

    map[:topic][:user_reactioned_ids] = @topic.reactions.where(user_cookie_value: identity_id).pluck(:icon_id)
    comment_ids = @topic.comments.pluck(:id)
    comment_ids.each { |comment_id| map[:comment][comment_id][:user_reactioned_ids] = [] }

    ids = @topic.comment_reactions.ids
    icon_ids = @topic.comment_reactions.pluck(:icon_id).uniq
    map_ids = @topic.comment_reactions.where(id: ids,
                                             icon_id: icon_ids,
                                             user_cookie_value: identity_id).
                                             pluck(:reactionable_id, :icon_id)

    map_ids.each do |comment_id, icon_id|
      map[:comment][comment_id][:user_reactioned_ids] << icon_id
    end

    map[:topic][:order] = @topic.reactions.pluck(:icon_id).uniq
    map_ids = @topic.comment_reactions.pluck(:reactionable_id, :icon_id).uniq
    comment_ids = @topic.comments.ids
    comment_ids.each do |comment_id|
      map[:comment][comment_id][:order] = []
    end
    map_ids.each do |comment_id, icon_id|
      map[:comment][comment_id][:order] << icon_id
    end
    render json: map, status: 200
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
                                  :image)
  end
end
