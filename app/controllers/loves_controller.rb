class LovesController < ApplicationController
  skip_before_action :require_login, only: %i(index show)
  before_action :set_categories, only: %i(index show new)
  before_action :set_love, only: %i(show edit update destroy)
  before_action :set_loves, only: :index

  def index
  end

  def show
  end

  def new
    @love = Love.new
  end

  def create
    @love = current_user.loves.build(love_params)
    if @love.save
      redirect_to @love, notice: t('love_was_successfully_created')
    else
      render :new
    end
  end

  def edit
  end

  def destroy
    @love.destroy
    redirect_to loves_path, notice: t('love_was_successfully_deleted')
  end

  private

  def set_categories
    @categories = LoveCategory.all
  end

  def set_love
    @love = Love.find(params[:id])
  end

  def set_loves
    @loves = Love.includes(:category, :taggings, :member)
      .order(created_at: :desc).page(params[:page])
  end

  def love_params
    params.require(:love).permit(:body,
                                 :category_id,
                                 :title)
  end
end
