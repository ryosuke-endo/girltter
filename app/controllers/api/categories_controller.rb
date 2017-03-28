class Api::CategoriesController < ApplicationController
  def index
    @categories = Category.cached.values
  end
end
