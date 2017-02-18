json.array! @emojis do |emoji|
  json.category emoji.category
  json.image_path image_path("emoji/#{emoji.image_filename}")
end
