require 'active_record/fixtures'

PATH = "#{Rails.root}/db/fixtures".freeze

def import_fixture(fixture)
  puts "import #{fixture}"
  ActiveRecord::FixtureSet.create_fixtures(PATH, fixture)
end

# categoryの画像を保存するために、importしない
puts 'import category'
categories = YAML.load(File.open("#{PATH}/categories.yml"))
categories.each do |_, category|
  id = category['id']
  name = category['name']
  description = category['description']
  position =  category['position']
  image_path = "#{PATH}/categories/image/#{id}.jpg"
  Category.create(name: name,
                  description: description,
                  position: position,
                  image: open(image_path))
end

# URL変換されないため、直接createする
puts 'import topics'
topics = YAML.load(File.open("#{PATH}/topics.yml"))
topics.each do |_, topic|
  category_id = topic['category_id']
  title = topic['title']
  name = topic['name']
  body = topic['body']
  Topic.create(category_id: category_id,
               title: title,
               name: name,
               body: body)
end

import_fixture(:members)
import_fixture(:tags)
