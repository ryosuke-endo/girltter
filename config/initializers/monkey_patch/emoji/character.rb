module Emoji
  class Character
    def style_class
      "emoji-#{hex_inspect}"
    end
  end
end
