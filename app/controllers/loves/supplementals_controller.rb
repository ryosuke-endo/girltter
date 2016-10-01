class Loves::SupplementalsController < ApplicationController
  before_action :set_categories, only: %i(new create)
  before_action :set_love

  def new
    @supplemental = @love.supplementals.build
  end

  def create
    @supplemental = @love.supplementals.build(supplemental_params)
    if @supplemental.save
      redirect_to @love, notice: t('supplemental_was_successfully_created')
    else
      render :new
    end
  end

  def destroy
  end

  private

  def supplemental_params
    params.require(:supplemental).permit(:body)
  end

  def set_love
    @love = Love.find(params[:love_id])
  end

  def set_categories
    @categories = LoveCategory.all
  end
end
