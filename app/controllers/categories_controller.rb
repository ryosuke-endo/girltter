class CategoriesController < ApplicationController
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
end
