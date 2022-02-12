source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Autoload dotenv in Rails
gem 'dotenv-rails', '~> 2.7', '>= 2.7.5'
# Use Redis adapter to run Action Cable in production
gem 'hiredis', '~> 0.6.3'
gem 'redis', '~> 4.1', '>= 4.1.3'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem 'sidekiq', '~> 6.0', '>= 6.0.6'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'faker', '~> 2.11'

  gem 'rubocop', '~> 0.80.1', require: false

  gem "capistrano", "~> 3.13", require: false
  gem "capistrano-rails", "~> 1.4", require: false
  gem 'capistrano-rbenv', '~> 2.1', require: false
  gem 'capistrano-bundler', '~> 1.6', require: false
  gem 'capistrano-sidekiq', '~> 1.0', require: false
  gem 'capistrano3-puma', '~> 4.0', require: false
  gem 'capistrano3-nginx', '~> 3.0', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
