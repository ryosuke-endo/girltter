class LovesController < ApplicationController
  skip_before_action :require_login, only: %i(index show)

  def index

  end

  def show

  end

  def new

  end
end
