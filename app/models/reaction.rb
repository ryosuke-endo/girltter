class Reaction < ActiveRecord::Base
  belongs_to :icon
  belongs_to :reactionable, polymorphic: true

  validates :reactionable_id,
            uniqueness: { scope: [:icon_id, :user_cookie_value, :reactionable_type] }
  validate :user_limit_reaction

  private

  def user_limit_reaction
    count = Reaction.where(reactionable_id: reactionable_id,
                           reactionable_type: reactionable_type,
                           user_cookie_value: user_cookie_value).
                           size
    if 5 <= count
      errors.add(:reactionable_id, "1人のユーザーが絵文字をつけれるのは、最大5個までです。")
    end
  end
end
