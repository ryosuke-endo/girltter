class Admin::Tags::AssociateWithModelsController < AdminController
  def new
  end

  def create
    Love.update_tags!
    redirect_to admin_tags_url, notice: t('admin_tags_associate_with_models_was_successfully_created')
  end
end
