class MembersController < ApplicationController
  layout 'my_page', only: %i(edit show)
  skip_before_action :require_login, only: %i(new create)
  before_action :set_member, only: %i(show edit update destroy)

  def index
    @members = Member.all
  end

  def show
    @threads = @member.loves.order(created_at: :desc)
      .includes(:category, :tags)
    answer_ids = @member.comments.answer_ids - @member.loves.pluck(:id)
    @answers = Love.where(id: answer_ids)
  end

  def new
    @member = Member.new
    render layout: 'one_column'
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
      redirect_to @member, notice: t('member_was_successfully_updated')
    else
      render :edit, layout: 'my_page'
    end
  end

  def destroy
    @member.destroy
    redirect_to members_url, notice: t('member_was_successfully_deleted')
  end

  private
    def set_member
      @member = current_user
    end

    def member_params
      params.require(:member).permit(:email,
                                     :login,
                                     :name,
                                     :password,
                                     :password_confirmation,
                                     :sex)
    end
end
