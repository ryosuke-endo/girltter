class TopicsController < ApplicationController
  include Cookie
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
    @reactioned_ids = {
      topic: @topic.reactions.pluck(:icon_id),
      comment: {}
    }
    ids = @topic.comment_reactions.ids
    icon_ids = @topic.comment_reactions.pluck(:icon_id).uniq
    map_ids = @topic.comment_reactions.where(id: ids,
                                             icon_id: icon_ids,
                                             user_cookie_value: identity_id).
                                             pluck(:reactionable_id, :icon_id)
    map_ids.each do |ids|
      reactionable_id = ids.first
      icon_id = ids.last
      @reactioned_ids[:comment][reactionable_id] = [] if @reactioned_ids[:comment][reactionable_id].blank?
      @reactioned_ids[:comment][reactionable_id].push(icon_id)
    end
    render layout: 'topic'
  end

  def count_map
    @topic = Topic.find(params[:topic_id])
    map = {
      topic: @topic.icons.group(:id).count,
      comment: {}
    }
    map_ids = @topic.comment_reactions.group(:reactionable_id, :icon_id).count
    map_ids.each do |ids, count|
      reactionable_id = ids.first
      icon_id = ids.last
      map[:comment][reactionable_id] = {} if map[:comment][reactionable_id].blank?
      map[:comment][reactionable_id][icon_id] = count
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
                                  :thumbnail)
  end
end
