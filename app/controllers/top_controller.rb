class TopController < ApplicationController
  skip_before_action :require_login
  before_action :set_category

  def index
  end

  private

  def set_category
    @love_categories = LoveCategory.all
  end
end
