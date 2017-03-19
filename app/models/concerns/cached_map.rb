module CachedMap
  extend ActiveSupport::Concern

  included do
    class_attribute :cached_map
  end

  class_methods do
    def cached
      fetch_cached_map
    end

    def find_cached(id)
      cached[id.to_i]
    end

    def fetch_cached_map
      if cached_map.blank?
        self.cached_map = order(:id).map.map { |x| [x.id, x] }.to_h
      else
        cached_map
      end
    end
  end
end
