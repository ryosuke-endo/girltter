module ApplicationHelper
  def category?
    controller_path == "categories"
  end

  def admin?
    current_user.class == Admin
  end
end
