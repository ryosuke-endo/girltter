class TopController < ApplicationController
  before_action :set_topics
  before_action :set_tag_ranking, if: :pc?

  def index
    @rankings = Analysis.yesterday_topic_ranking.limit(5)
  end

  private

  def set_topics
    @topics = Topic.order(created_at: :desc).page(params[:page])
  end

  def set_tag_ranking
    @tag_ranking = ActsAsTaggableOn::Tag.most_used
  end
end
