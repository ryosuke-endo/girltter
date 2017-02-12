class Api::EmojiController < ApplicationController
  skip_before_action :require_login

  def index
    query = JSON.parse(params[:query]).with_indifferent_access
    @emojis = Api::EmojiIndexService.new(query).result.first(100)
  end
end
