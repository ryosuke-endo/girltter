require 'active_record/fixtures'

PATH = "#{Rails.root}/db/fixtures".freeze

def import_fixture(fixture)
  puts "import #{fixture}"
  ActiveRecord::FixtureSet.create_fixtures(PATH, fixture)
end

categories = YAML.load(File.open("#{PATH}/categories.yml"))
puts 'import category'
categories.each do |_, category|
  id = category['id']
  name = category['name']
  description = category['description']
  image_path = "#{PATH}/categories/image/#{id}.jpg"
  Category.create(name: name,
                  description: description,
                  image: open(image_path))
end

import_fixture(:members)
import_fixture(:tags)
import_fixture(:loves)
import_fixture(:topics)

Love.update_tags!
