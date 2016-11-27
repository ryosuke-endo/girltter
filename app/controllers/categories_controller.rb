class CategoriesController < ApplicationController
  skip_before_action :require_login

  before_action :set_tag_ranking
  before_action :set_ranking

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

  def set_ranking
    @rankings = Ranking.where(start_date: DateTime.yesterday).
      order(read_count: :desc).
      limit(5)
  end
end
