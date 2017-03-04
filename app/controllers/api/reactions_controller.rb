class Api::ReactionsController < ApplicationController
  skip_before_action :require_login

  def create
    reactionable =
      if params[:type].constantize == Comment
        Comment.find(params[:reactionable_id])
      end
    icon = Icon.find_by_hexname(params[:icon][:name])
    reaction = reactionable.reactions.build(icon_id: icon.id,
                                            reactionable_id: reactionable.id)
    if reaction.save
      head :ok
    else
      head :not_found
    end
  end
end
