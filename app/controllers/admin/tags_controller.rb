class Admin::TagsController < AdminController
  before_action :set_tags

  def index
  end

  private

  def set_tags
    @tags = ActsAsTaggableOn::Tag.all
  end
end
