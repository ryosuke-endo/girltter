json.array! @icons do |icon|
  json.id icon.id
  json.name icon.hex_name
  json.category IconCategory.find_cached(icon.category.id).name
  json.style_class icon.style_class
end
