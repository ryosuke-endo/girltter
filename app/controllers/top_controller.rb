class TopController < ApplicationController
  skip_before_action :require_login
  before_action :set_categories
  before_action :set_loves

  def index
  end

  private

  def set_loves
    @loves = Love.order(created_at: :desc).page(params[:page])
  end

  def set_categories
    @categories = LoveCategory.all
  end
end
