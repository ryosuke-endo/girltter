class TopicsController < ApplicationController
  layout 'one_column'
  skip_before_action :require_login

  before_action :set_categories

  def new
    @topic = Topic.new
  end

  private

  def set_categories
    @categories = Category.all
  end
end
