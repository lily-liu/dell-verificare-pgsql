source 'https://rubygems.org'

# set ruby version on heroku to ensure stability
ruby '2.3.1'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# asset pipeline for pdf
gem 'sprockets-rails'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# for image uload and manipulation
gem 'fog-aws'
gem 'carrierwave'
gem 'mini_magick'

# oauth2 jwt gem for authentication gem
gem 'knock'
gem 'pundit'

# for bulk inserting sellin in db gem
gem 'activerecord-import'

# for soft deletion record on db gem
gem 'paranoia'

# onesignal wrapper for push notification gem
gem 'one_signal'

# csv handling lib and wrapper gem
gem 'smarter_csv'
gem 'to_csv-rails'
gem 'julia_builder'

# powerpoint export gem
# gem 'powerpoint'

# export image gem
gem 'aws-sdk'
gem 'rubyzip'
# gem 'zipline'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
