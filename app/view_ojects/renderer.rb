class Renderer
  def renderer
    controller = ApplicationController.new
    controller.request = ActionDispatch::TestRequest.new
    ViewRenderer.new(Rails.root.join('app', 'views'), {}, controller)
  end
end
