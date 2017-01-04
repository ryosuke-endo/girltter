require 'active_record/fixtures'

def import_fixture(fixture)
  puts "import #{fixture}"
  ActiveRecord::FixtureSet.create_fixtures("#{Rails.root}/db/fixtures", fixture)
end

categories = YAML.load(File.open("#{Rails.root}/db/fixtures/categories.yml"))
puts 'import category'
categories.each do |_, category|
  id = category['id']
  name = category['name']
  description = category['description']
  image_path = "#{Rails.root}/db/fixtures/categories/image/#{id}.jpg"
  Category.create(name: name,
                  description: description,
                  image: open(image_path))
end

import_fixture(:members)
import_fixture(:tags)
import_fixture(:loves)

Love.update_tags!
