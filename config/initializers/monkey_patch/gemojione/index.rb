module Gemojione
  class Index
    def all
      @emoji_by_moji
    end

    def find_by_category(category)
      @emoji_by_moji.select { |_, v| v["category"] == category }
    end
  end
end
