class CategoriesController < ApplicationController
  layout 'category'
  skip_before_action :require_login

  before_action :set_category
  before_action :set_tag_ranking

  def show
    @topics = @category.topics
  end

  private

  def set_category
    @category = Category.find(params[:id])
    @categories = Category.all
  end

  def set_tag_ranking
    ranking_ids = Tagging.ranking_ids("Love", 20)
    @tag_ranking = ActsAsTaggableOn::Tag.find(ranking_ids)
  end
end
