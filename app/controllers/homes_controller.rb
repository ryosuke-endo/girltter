class HomesController < ApplicationController
  layout 'home'
  before_action :set_member

  def show
    @threads = @member.loves.order(created_at: :desc)
      .includes(:category, :tags)
    answer_ids = @member.comments.answer_ids - @member.loves.pluck(:id)
    @answers = Love.where(id: answer_ids)
  end

  def edit
  end

  def update
    @member.skip_validate_password = true
    if @member.update(member_params)
      redirect_to @member, notice: t('member_was_successfully_updated')
    else
      render :edit, layout: 'home'
    end
  end

  def email
  end

  def password
  end

  def update_email
    @member.skip_validate_password = true
    if @member.update(member_params)
      redirect_to @member, notice: t('member_was_successfully_updated_email')
    else
      render :email, layout: 'home'
    end
  end

  def update_password
    if @member.update(member_params)
      redirect_to @member, notice: t('member_was_successfully_updated_password')
    else
      render :password, layout: 'home'
    end
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