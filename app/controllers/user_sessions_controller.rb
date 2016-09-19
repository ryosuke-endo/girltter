class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = login(params[:email], params[:password])
    if user
      redirect_back_or_to(:users, notice: 'ログインに成功しました')
    else
      flash.now[:alert] = 'ログインに失敗しました'
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to(:users, notice: 'ログアウト')
  end
end
