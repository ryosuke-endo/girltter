class Topics::CommentsController < Topics::ApplicationController

  def anchor
    topic = Topic.find(params[:topic_id])
    no = params[:no].to_i
    anchor =
      if no == 1
        topic
      else
        topic.comments[no - 2]
      end
    status = anchor.present? ? 200 : 404
    text = render_to_string partial: 'anchor',
                            locals: { no: no,
                                      anchor: anchor }
    render text: text, status: status
  end
end
