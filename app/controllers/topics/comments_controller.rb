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
    if anchor.present?
      text = render_to_string partial: 'anchor',
                              locals: { no: no,
                                        anchor: anchor }
      render text: text
    else
      text = render_to_string partial: 'anchor_error'
      render text: text, status: 404
    end
  end
end
