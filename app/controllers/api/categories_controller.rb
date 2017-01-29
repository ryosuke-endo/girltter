class Api::CategoriesController < ApplicationController
  skip_before_action :require_login

  def index
    @categories = Category.all
  end
end
