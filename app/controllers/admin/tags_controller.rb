class Admin::TagsController < AdminController
  before_action :set_tags

  def index
  end

  def show
  end

  def new
    @tag = ActsAsTaggableOn::Tag.new
  end

  def create
    @tag = ActsAsTaggableOn::Tag.new(name: params[:name])
    if @tag.save
      redirect_to admin_tags_path
    else
      render 'new'
    end
  end

  def destroy
    tag = ActsAsTaggableOn::Tag.find(params[:id])
    tag.destroy
    redirect_to admin_tags_path, notice: t('tag_was_successfully_deleted')
  end

  private

  def set_tags
    @tags = ActsAsTaggableOn::Tag.page(params[:page]).per(25)
  end
end
