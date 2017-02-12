module Api
  class EmojiIndexService
    attr_reader :collection, :query

    def initialize(query)
      @collection = Gemojione.index.all.with_indifferent_access
      @query = query
    end

    def result
      filter_category
      filter_name
      collection.values
    end

    private

    def filter_category
      return collection if query[:category].blank?
      collection.select! { |_, value| value[:category] == query[:category] }
    end

    def filter_name
      return collection if query[:name].blank?
      collection.select! { |_, value| value[:name] == query[:name] }
    end
  end
end
