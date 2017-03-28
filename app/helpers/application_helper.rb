module ApplicationHelper
  def category?
    controller_path == "categories"
  end
end
