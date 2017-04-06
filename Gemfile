source 'https://rubygems.org'

gem 'rails', '5.0.2'

# DB
gem 'mysql2'

# bulk insert
gem 'activerecord-import'

# memcached
gem 'dalli'

# image
gem 'paperclip'

gem 'bcrypt', '~> 3.1.7'

# pagination
gem 'kaminari'

# slim
gem 'slim-rails'

# Application server
gem 'unicorn'

# unicorn automatically reset
gem 'unicorn-worker-killer'

# cron
gem 'whenever', require: false

# css
gem 'sass-rails'
gem 'autoprefixer-rails'
gem 'bootstrap-sass'

# emoji
gem 'gemoji'

# breadcrumbs
gem 'gretel'

# thumbnail link
gem 'link_thumbnailer'

# icon
gem 'font-awesome-rails'

# javascript
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'webpacker'

gem 'uglifier', '>= 1.3.0'

# json
gem 'jbuilder', '~> 2.0'
gem 'oj'

# document
gem 'sdoc', '~> 0.4.0', group: :doc

# decorator
gem 'active_decorator'

# tags
gem 'acts-as-taggable-on'

# SEO
gem 'meta-tags'

# error mail
gem 'exception_notification'

# device sort
gem 'jpmobile'

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
  gem 'timecop'

  # driver
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'selenium-webdriver'
  gem 'launchy'
  gem 'capybara_switch_driver'

  # helper
  gem 'active_decorator-rspec'
  gem 'rails-controller-testing'

  # mock
  gem 'webmock'
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
  gem 'capistrano-nvm'
  gem 'capistrano3-unicorn'
end
