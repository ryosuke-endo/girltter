class Topics::CommentsController < Topics::ApplicationController
  def anchor
    topic = Topic.find(params[:topic_id])
    no = params[:no].to_i
    anchor = no == 1 ? topic : topic.comments[no - 2]
    text = render_to_string partial: 'anchor',
                            locals: { no: no,
                                      anchor: anchor }
    render text: text, status: 200
  end
end
