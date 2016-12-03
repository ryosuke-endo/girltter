require 'active_record/fixtures'

def import_fixture(fixture)
  puts "import #{fixture}"
  ActiveRecord::FixtureSet.create_fixtures("#{Rails.root}/db/fixtures", fixture)
end

categories = YAML.load(File.open("db/fixtures/categories.yml"))
categories.each do |category|
  id = category.last['id']
  name = category.last['name']
  description = category.last['description']
  image_path = "#{Rails.root}/db/fixtures/categories/image/#{id}.jpg"
  Category.create(name: name,
                  description: description,
                  image: open(image_path))
end
import_fixture(:members)
import_fixture(:tags)
import_fixture(:loves)

Love.update_tags!
