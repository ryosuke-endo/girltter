class TopController < ApplicationController
  layout 'top'

  skip_before_action :require_login
  before_action :set_topics
  before_action :set_tag_ranking

  def index
  end

  private

  def set_topics
    @topics = Topic.order(created_at: :desc).page(params[:page])
  end

  def set_tag_ranking
    @tag_ranking = ActsAsTaggableOn::Tag.most_used
  end
end
