class Topics::ApplicationController < ApplicationController
  skip_before_action :require_login

  layout 'topic'
end
