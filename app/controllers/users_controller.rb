class UsersController < ApplicationController
  layout 'one_column'
  skip_before_action :require_login, only: %i(new create)
  before_action :set_user, only: %i(show edit update destroy)

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to @user, notice: t('user_was_successfully_created')
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: t('user_was_succesfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: t('user_was_successfully_deleted')
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email,
                                   :login,
                                   :password,
                                   :password_confirmation)
    end
end
