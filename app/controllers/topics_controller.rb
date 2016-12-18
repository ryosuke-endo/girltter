class TopicsController < ApplicationController
  layout 'one_column'
  skip_before_action :require_login

  before_action :set_categories

  def new
    @topic = Topic.new
  end

  def confirm
    @topic = Topic.new(topic_params)
    if @topic.invalid?
      render :new
    else
      @contents = ContentsView.new(@topic.body, view_context)
    end
  end

  private

  def set_categories
    @categories = Category.all
  end

  def topic_params
    params.require(:topic).permit(:title,
                                  :body,
                                  :category_id,
                                  :name,
                                  :temp_file,
                                  :thumbnail)
  end
end
