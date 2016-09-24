def import_fixture(fixture)
  puts "import #{fixture}"
  ActiveRecord::FixtureSet.create_fixtures("#{Rails.root}/db/fixtures", fixture)
end

import_fixture(:love_catrgories)
