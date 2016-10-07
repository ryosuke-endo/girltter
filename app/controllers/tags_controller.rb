class TagsController < ApplicationController
  def show
    @threads = []
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    tags_type = Tagging.where(tag_id: @tag.id)
                       .pluck(:taggable_type).uniq
    tags_type.each do |type|
      case type
      when 'Love'
        @threads << Love.tagged_with(@tag.name)
      end
    end
    @threads.flatten!
  end
end
