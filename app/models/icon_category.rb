class IconCategory < ActiveRecord::Base
  include CachedMap

  has_many :icons
  validates :name, presence: true
end
