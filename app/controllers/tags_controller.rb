class TagsController < ApplicationController
  skip_before_action :require_login
  before_action :set_tag

  def show
    @threads = Kaminari.paginate_array(threads).page(params[:page])
  end

  private

  def set_tag
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
  end

  def threads
    threads = []
    tags_type = Tagging.where(tag_id: @tag.id)
                       .pluck(:taggable_type).uniq
    tags_type.each do |type|
      case type
      when 'Love'
        threads << Love.tagged_with(@tag.name)
      end
    end
    threads.flatten!
  end
end
