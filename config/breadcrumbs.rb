crumb :root do
  link "トップページ", root_path
end

crumb :category do |category|
  link "#{category.name}"
end

crumb :category_top do |name|
  link "#{name}"
end

crumb :tag do |tag|
  link "#{tag.name}"
end

crumb :topic do |topic|
  category = topic.category
  link "#{category.name}", category_path(category.id)
  link "#{topic.title}"
end
