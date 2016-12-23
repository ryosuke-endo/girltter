class TopicsController < ApplicationController
  layout 'one_column'
  skip_before_action :require_login

  before_action :set_categories
  before_action :set_topic

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params.except(:thumbnail))
    if params[:back]
      render :new
      return
    end

    if params[:topic][:thumbnail]
      temp = TempFile.find(params[:topic][:thumbnail])
      @topic.thumbnail = temp.temp
    end

    if @topic.save
      render :complete
    else
      render :new
    end
  end

  def confirm
    @topic = Topic.new(topic_params)
    if @topic.invalid?
      render :new
    else
      @contents = ContentsView.new(@topic.body, view_context)
    end
  end

  def complete
  end

  def show
    render layout: 'application'
  end

  private

  def set_categories
    @categories = Category.all
  end

  def set_topic
    @topic = Topic.find(params[:id])
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
