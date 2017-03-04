json.array! @emojis do |emoji|
  json.name emoji.hex_inspect
  json.category emoji.category
  json.style_class emoji.style_class
end
