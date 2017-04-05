class TagsController < ApplicationController
  before_action :set_tag_ranking

  def index
    @tag = ActsAsTaggableOn::Tag.find_by(name: params[:name])
    topics = Topic.tagged_with(@tag.name)
    @topics = Kaminari.paginate_array(topics).page(params[:page])
  end

  def set_tag_ranking
    @tag_ranking = ActsAsTaggableOn::Tag.most_used
  end
end
