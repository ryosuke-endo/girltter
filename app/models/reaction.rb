class Reaction < ActiveRecord::Base
  belongs_to :icon
  belongs_to :reactionable, polymorphic: true
end
