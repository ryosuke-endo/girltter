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

crumb :thread do |thread|
  category = thread.category
  link "#{category.name}", category_path(category.id)
  link "#{thread.title}"
end

crumb :search_topics do
  link '検索する'
end
