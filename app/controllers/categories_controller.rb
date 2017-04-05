class CategoriesController < ApplicationController
  before_action :set_category
  before_action :set_tag_ranking

  def show
    @topics = @category.topics.
      order(created_at: :desc).
      page(params[:page])
  end

  private

  def set_category
    @category = Category.find(params[:id])
    @categories = Category.all
  end

  def set_tag_ranking
    @tag_ranking = ActsAsTaggableOn::Tag.most_used
  end
end
