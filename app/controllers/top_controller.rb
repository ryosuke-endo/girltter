class TopController < ApplicationController
  skip_before_action :require_login
  before_action :set_categories
  before_action :set_loves
  before_action :set_tag_ranking

  def index
  end

  private

  def set_loves
    @loves = Love.includes(:category, :taggings, :member)
      .order(created_at: :desc).page(params[:page])
  end

  def set_categories
    @categories = LoveCategory.all
  end

  def set_tag_ranking
    @tag_ranking = ActsAsTaggableOn::Tag.most_used
  end
end
