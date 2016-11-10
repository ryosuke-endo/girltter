class MembersController < ApplicationController
  layout 'home', only: :show
  skip_before_action :require_login, only: %i(index new create)
  before_action :set_member, only: %i(show destroy)
  before_action :authenticate_admin!, only: :index

  def index
    @members = Member.all
  end

  def show
    @threads = @member.loves.order(created_at: :desc)
      .includes(:category, :tags)
      .page(params[:thread_page])
    answer_ids = @member.comments.answer_ids - @member.loves.pluck(:id)
    @answers = Love.where(id: answer_ids).page(params[:answer_page])
  end

  def new
    @member = Member.new
    render layout: 'one_column'
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      auto_login(@member)
      redirect_to home_url, notice: t('member_was_successfully_created')
    else
      render :new, layout: 'one_column'
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
