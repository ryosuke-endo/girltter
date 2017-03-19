class IconCategory < ActiveRecord::Base
  class_attribute :cached_map
  has_many :icons

  def self.cached
    fetch_cached_map
  end

  def self.find_cached(id)
    cached[id.to_i]
  end

  def self.fetch_cached_map
    if cached_map.blank?
      self.cached_map = order(:id).map.map { |x| [x.id, x] }.to_h
    else
      cached_map
    end
  end

  private_class_method :fetch_cached_map
end
