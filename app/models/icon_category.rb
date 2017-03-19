class IconCategory < ActiveRecord::Base
  include CachedMap

  class << self
    alias_method :cached, :fetch_cached_map
  end
  has_many :icons
  validates :name, presence: true
end
