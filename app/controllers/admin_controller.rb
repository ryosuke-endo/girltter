class AdminController < ApplicationController
  before_action :authenticate_admin!
  layout 'one_column'
 
  def index
  end
end
