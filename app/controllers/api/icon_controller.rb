class Api::IconController < ApplicationController
  skip_before_action :require_login

  def index
    @icons = Icon.select(:id, :image_file_name, :icon_category_id).all
  end
end
