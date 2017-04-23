class TopController < ApplicationController
  before_action :set_topics
  before_action :set_tag_ranking, if: :pc?

  def index
    @rankings = Analysis.topic_ranking(Date.yesterday).limit(5)
    if @rankins.blank?
      @rankings = Analysis.topic_ranking(Date.yesterday - 1.day).limit(5)
    end
  end

  private

  def set_topics
    @topics = Topic.order(created_at: :desc).page(params[:page])
  end

  def set_tag_ranking
    @tag_ranking = ActsAsTaggableOn::Tag.most_used
  end
end
