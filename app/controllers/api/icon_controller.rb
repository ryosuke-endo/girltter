class Api::IconController < ApplicationController
  def index
    @icons = Icon.all
  end
end
