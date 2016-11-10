source 'https://rubygems.org'

gem 'rails', '4.2.7.1'

gem 'sprockets', git: 'git@github.com:rails/sprockets.git', branch: 'master'
gem 'babel-transpiler'

# DB
gem 'mysql2'

# Authentication library
gem 'sorcery'
gem 'bcrypt', '~> 3.1.7'

# pagination
gem 'kaminari'

# slim
gem 'slim-rails'

# Application server
gem 'unicorn'

# css
gem 'sass-rails'
gem 'autoprefixer-rails'
gem 'bootstrap-sass'

# icon
gem 'font-awesome-rails'

# javascript
gem 'coffee-rails', '~> 4.1.0'
gem 'therubyracer', platforms: :ruby

# library
gem 'parsley-rails'

gem 'uglifier', '>= 1.3.0'

# json
gem 'jbuilder', '~> 2.0'

# document
gem 'sdoc', '~> 0.4.0', group: :doc

# decorator
gem 'active_decorator'

# tags
gem 'acts-as-taggable-on'

# validation
gem 'simple_email_validation'

# enum i18n helper
gem 'enum_help'

group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'

  gem 'faker'

  # test coverage
  gem 'codecov', require: false
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'

  # driver
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'selenium-webdriver'
  gem 'launchy'
  gem 'capybara_switch_driver'
end

group :development do
  gem 'web-console', '~> 2.0'

  # Better errors handler
  gem 'better_errors'
  gem 'binding_of_caller'

  # css source map
  gem 'view_source_map'

  # performance
  gem 'bullet'
  gem 'rack-mini-profiler'

  gem 'spring'
  gem 'spring-commands-rspec'
end

group :production do
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'capistrano-yarn'
  gem 'capistrano-nodebrew'
  gem 'capistrano3-unicorn'
end
