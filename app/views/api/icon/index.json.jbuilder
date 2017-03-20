json.cache! ['icons', @icons], expires_in: 30.minutes do
  json.array! @icons do |icon|
    json.id icon.id
    json.category IconCategory.find_cached(icon.category.id).name
    json.image_file_name icon.image_file_name
  end
end
