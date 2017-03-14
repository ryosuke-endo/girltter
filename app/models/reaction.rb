class Reaction < ActiveRecord::Base
  belongs_to :icon
  belongs_to :reactionable, polymorphic: true

  validates :reactionable_id,
            uniqueness: { scope: [:icon_id, :user_cookie_value, :reactionable_type] }
end
