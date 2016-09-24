class TopController < ApplicationController
  skip_before_action :require_login
  before_action :set_categories

  def index
  end

  private

  def set_categories
    @categories = LoveCategory.all
  end
end
