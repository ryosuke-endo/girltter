class Reaction < ActiveRecord::Base
  belongs_to :icon
  belongs_to :reactionable, polymorphic: true

  validates_uniqueness_of :reactionable_id, scope: [:icon_id, :user_cookie_value, :reactionable_type]
end
