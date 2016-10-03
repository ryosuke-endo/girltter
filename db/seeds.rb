require 'active_record/fixtures'

def import_fixture(fixture)
  puts "import #{fixture}"
  ActiveRecord::FixtureSet.create_fixtures("#{Rails.root}/db/fixtures", fixture)
end

import_fixture(:categories)
import_fixture(:loves)
import_fixture(:members)
import_fixture(:tags)
