module Api
  class EmojiIndexService
    attr_reader :collection, :query

    def initialize(query)
      @collection = Emoji.all
      @query = query
    end

    def result
      # filter_category
      # filter_name
      # filter_blank_keywords
      # order_unicode
      # collection.values
      collection
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

    def filter_blank_keywords
      collection.select! { |_, value| value[:keywords].present? }
    end

    def order_unicode
      collection.each do |key, value|
        value.sort { |(k, v), (k2, v2)| k[1] <=> k2[1] }
      end
    end
  end
end
