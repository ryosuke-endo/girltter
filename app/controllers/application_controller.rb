class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :set_identity_cookie

  protect_from_forgery with: :exception

  private

  def not_authenticated
    redirect_to login_path, alert: 'ログインしてください'
  end

  def set_identity_cookie
    return if cookies['_cadr'].present?
    hash_ip = Digest::MD5.hexdigest(request.remote_ip)
    cookies.permanent['_cadr'] = {
      value: Time.zone.now.to_s(:yyyymmdd) + hash_ip
    }
  end

  def authenticate_admin!
    if current_user.class != Admin
      redirect_to root_path
    end
  end
end
