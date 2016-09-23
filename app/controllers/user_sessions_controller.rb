class UserSessionsController < ApplicationController
  layout 'one_column'
  skip_before_action :require_login, except: :destroy

  def new
    @user = User.new
  end

  def create
    user = login(params[:email], params[:password])
    if user
      redirect_back_or_to(:users, notice: I18n.t('login_was_successfully_created'))
    else
      flash.now[:alert] = I18n.t('login_was_failed')
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to(:users, notice: I18n.t('login_was_successfully_deleted'))
  end
end
