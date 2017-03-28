class Api::TopicsController < ApplicationController
  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      render json: @topic, status: 200
    else
      render json: { errors: @topic.errors,
                     error_messages: @topic.errors.full_messages },
             status: 422
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:title,
                                  :body,
                                  :category_id,
                                  :name,
                                  :thumbnail)
  end
end
