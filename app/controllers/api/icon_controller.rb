class Api::IconController < ApplicationController
  skip_before_action :require_login

  def index
    @icons = Icon.all
  end
end
