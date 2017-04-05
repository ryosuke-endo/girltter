class TagsController < ApplicationController

  def index
    @tag = ActsAsTaggableOn::Tag.find_by(name: params[:name])
    topics = Tagging.where(tag_id: @tag.id, taggable_type: 'Topic')
    @topics = Kaminari.paginate_array(topics).page(params[:page])
  end
end
