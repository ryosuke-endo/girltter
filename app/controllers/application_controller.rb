class ApplicationController < ActionController::Base
  before_action :require_login

  protect_from_forgery with: :exception

  private

  def not_authenticated
    redirect_to login_path, alert: 'ログインしてください'
  end

  def authenticate_admin!
    if current_user.class != Admin
      redirect_to root_path
    end
  end
end
