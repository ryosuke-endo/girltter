class LovesController < ApplicationController
  skip_before_action :require_login, only: %i(index show)
  before_action :set_categories

  def index

  end

  def show

  end

  def new

  end

  def set_categories
    @categories = LoveCategory.all
  end
end
