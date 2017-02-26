module Api
  class EmojiIndexService
    attr_reader :collection, :query

    def initialize(query)
      @collection = Emoji.all
      @query = query
    end

    def result
      except!
      collection
    end

    private

    def except!
      if query[:except].present?
        if query[:except][:unicode_version]
          collection.select! { |x| x.unicode_version != query[:except][:unicode_version] }
        end
        if query[:except][:ios_version]
          collection.select! { |x| x.ios_version != query[:except][:ios_version] }
        end
      end
    end
  end
end
