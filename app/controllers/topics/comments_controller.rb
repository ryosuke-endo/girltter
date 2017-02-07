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
    partial = anchor.present? ? 'anchor' : 'anchor_error'
    text = render_to_string partial: partial,
                            locals: { no: no,
                                      anchor: anchor }
    render text: text
  end
end
