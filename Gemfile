source 'https://rubygems.org'
ruby '2.3.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
gem 'bootstrap-sass', '~> 3.3.0'
gem 'bootswatch-rails'
gem 'autoprefixer-rails'
gem 'rails-i18n', '~> 4.0.0'
gem 'devise'
gem 'devise-i18n'
gem 'faker'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'dragonfly', '~> 1.0.11'
gem 'avatar_magick', '~> 1.0.1'
# gem 'mailgun_rails'
# gem 'mailgunner', '~> 2.4'
# gem 'omniauth'
# gem 'omniauth-facebook'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails', require: false
  gem 'spork-rails'
  gem 'spork', github: 'sporkrb/spork'
  gem 'guard-spork'
  gem 'childprocess'
  gem 'factory_girl_rails'
  # gem 'selenium-webdriver'
  gem 'poltergeist'
  gem 'simple_form'
  gem 'datetimepicker-rails', github: 'zpaulovics/datetimepicker-rails', branch: 'master', submodules: true
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
group :production do
  gem 'rails_12factor'
end
