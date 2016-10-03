class MembersController < ApplicationController
  layout 'one_column'
  skip_before_action :require_login, only: %i(new create)
  before_action :set_member, only: %i(show edit update destroy)

  def index
    @members = Member.all
  end

  def show
  end

  def new
    @member = Member.new
  end

  def edit
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      auto_login(@member)
      redirect_to @member, notice: t('member_was_successfully_created')
    else
      render :new
    end
  end

  def update
    if @member.update(member_params)
      redirect_to @member, notice: t('member_was_succesfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @member.destroy
    redirect_to members_url, notice: t('member_was_successfully_deleted')
  end

  private
    def set_member
      @member = Member.find(params[:id])
    end

    def member_params
      params.require(:member).permit(:email,
                                     :login,
                                     :password,
                                     :password_confirmation)
    end
end
