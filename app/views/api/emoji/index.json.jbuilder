json.array! @emojis do |emoji|
  json.category emoji.category
  json.style_class emoji.style_class
end
