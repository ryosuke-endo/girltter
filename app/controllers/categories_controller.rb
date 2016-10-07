class CategoriesController < ApplicationController
  before_action :set_tag_ranking
  skip_before_action :require_login
  def show
    @category = Category.find(params[:id])
    @categories = @category.class.all
    @threads =
      case @category
      when LoveCategory
        @category.loves.includes(:category, :taggings, :member)
          .order(created_at: :desc).page(params[:page])
      end
  end

  private

  def set_tag_ranking
    ranking_ids = ActsAsTaggableOn::Tagging.where(taggable_type: "Love").
      group(:tag_id).order('count(tag_id) desc').limit(20).pluck(:tag_id)
    @tag_ranking = ActsAsTaggableOn::Tag.find(ranking_ids)
  end
end
