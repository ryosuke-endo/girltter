class LovesController < ApplicationController
  skip_before_action :require_login, only: %i(index show)
  before_action :set_categories
  before_action :set_loves

  def index
  end

  def show

  end

  def new

  end

  private

  def set_categories
    @categories = LoveCategory.all
  end

  def set_loves
    @loves = Love.order(created_at: :desc).page(params[:page])
  end
end
