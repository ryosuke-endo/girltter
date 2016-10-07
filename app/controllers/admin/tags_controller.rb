class Admin::TagsController < AdminController
  before_action :set_tags

  def index
  end

  def show
  end

  def new
    @tag = ActsAsTaggableOn::Tag.new
  end

  def create
  end

  private

  def set_tags
    @tags = ActsAsTaggableOn::Tag.all
  end
end
