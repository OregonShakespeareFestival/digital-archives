source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

gem 'autoprefixer-rails', '~> 5.2'

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
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'sufia', github: 'OregonShakespeareFestival/sufia', branch: 'osf_integration'
gem 'kaminari', github: 'jcoyne/kaminari', branch: 'sufia'

# Use our branch of hydra-access-controls.  This can go away once our PR is
# merged and we upgrade to the version containing our PR.
# See https://github.com/projecthydra/hydra-head/pull/287
gem "hydra-access-controls", github: "OregonShakespeareFestival/hydra-head", branch: "osf_integration"

gem 'production_credits', path: 'vendor/engines/production_credits'
gem 'rails_admin', github: 'codingzeal/rails_admin', branch: 'sufia-6.2.0'
gem "rails-observers", "~> 0.1.2"

gem 'rsolr', '~> 1.0.6'
gem 'devise'
gem 'devise-guests', '~> 0.3'

gem 'capistrano', '~> 3.1'
gem 'capistrano-rails', '~> 1.1'
gem 'capistrano-rvm'

source 'https://rails-assets.org' do
  gem 'rails-assets-ionrangeslider', '~> 2.0.2'
  gem 'rails-assets-image-picker', '~> 0.2.4'
  gem 'rails-assets-chosen', '~> 1.4'
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem 'meta_request'
  gem 'quiet_assets'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'rspec-rails'
  gem 'jettywrapper'
  gem "capybara"
  gem "factory_girl_rails"
  gem "faker", "~> 1.5"
end

group :test do
  gem "test_after_commit", "~> 0.4.1"
end

group :production do
  gem 'mysql2', '~> 0.3.18'
  gem 'unicorn-rails'
end
