class CategoriesController < ApplicationController
  before_action :set_tag_ranking
  skip_before_action :require_login
  def show
    @category = Category.find(params[:id])
    @categories = @category.class.all
    @threads =
      case @category
      when LoveCategory
        @category.loves.includes(:category, :tags, :member)
          .order(created_at: :desc).page(params[:page])
      end
  end

  private

  def set_tag_ranking
    ranking_ids = Tagging.ranking_ids("Love", 20)
    @tag_ranking = ActsAsTaggableOn::Tag.find(ranking_ids)
  end
end
