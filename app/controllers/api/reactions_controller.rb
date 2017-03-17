class Api::ReactionsController < ApplicationController
  include Cookie
  skip_before_action :require_login

  def create
    reactionable =
      if params[:type] == 'Comment'
        Comment.find(params[:reactionable_id])
      elsif params[:type] == 'Topic'
        Topic.find(params[:reactionable_id])
      end
    icon = Icon.find_by_hexname(params[:icon][:name])
    reaction = reactionable.reactions.build(icon_id: icon.id,
                                            reactionable_id: reactionable.id,
                                            user_cookie_value: identity_id)
    if reaction.save
      render json: {
        icon: icon,
        reactionable_id: reaction.reactionable_id,
        type: reaction.reactionable_type,
        emoji_class: icon.style_class
      },
             status: 200
    else
      head :not_found
    end
  end
end
