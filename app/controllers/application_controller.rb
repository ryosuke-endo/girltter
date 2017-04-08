class ApplicationController < ActionController::Base
  include Jpmobile::ViewSelector
  before_action :set_identity_cookie

  protect_from_forgery with: :exception

  private

  def set_identity_cookie
    return if cookies['_cadr'].present?
    hash_ip = Digest::MD5.hexdigest(request.remote_ip)
    cookies.permanent['_cadr'] = {
      value: Time.zone.now.to_s(:yyyymmdd) + hash_ip
    }
  end
end
