module Emoji
  class Character
    def style_class
      "emoji-#{image_filename.gsub(/(unicode\/|\.png)/, '')}"
    end
  end
end
