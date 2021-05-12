source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'pg', '>= 0.18', '< 2.0' # Use postgresql as the database for Active Record
gem 'puma' # Use Puma as the app server
gem 'rails', '~> 6.1.0' # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'sass-rails' # Use SCSS for stylesheets
gem 'webpacker', '~> 5.0' # Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker

gem 'jbuilder', '~> 2.5' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'redis', '~> 4.0' # Use Redis adapter to run Action Cable in production
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'acts-as-taggable-on' # With ActsAsTaggableOn, you can tag a single model on several contexts, such as skills, interests, and awards. It also provides other advanced functionality
gem 'bootsnap', '>= 1.4.2', require: false
gem 'carrierwave', '~> 2.1' # Upload files in your Ruby applications, map them to a range of ORMs, store them on different backends.
gem 'draper' # Draper adds an object-oriented layer of presentation logic to your Rails apps.
gem 'fog-aws' # This library can be used as a module for `fog` or as standalone provider to use the Amazon Web Services in applications..
gem 'kaminari' # Kaminari is a Scope & Engine based, clean, powerful, agnostic, customizable and sophisticated paginator for Rails 4+
gem 'paranoia' # Paranoia is a re-implementation of acts_as_paranoid for Rails 3, 4, and 5, using much, much, much less code.
gem 'pundit' # Object oriented authorization for Rails applications
gem 'ransack' # Object-based searching.
gem 'simple_form' # Forms made easy!
gem 'slim-rails' # Provides the generator settings required for Rails 3+ to use Slim
gem 'turbo-rails', '~> 0.5.8' # The speed of a single-page web application without having to write any JavaScript.
gem 'view_component' # View components for Rails, intended for upstreaming in Rails 6.1

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails' # factory_bot_rails provides integration between factory_bot and rails 4.2 or newer
  gem 'faker' # easily generate fake data: names, addresses, phone numbers, etc.
  gem 'rspec-collection_matchers'
  gem 'rspec-rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'bullet' # help to kill N+1 queries and unused eager loading.
  gem 'html2slim'
  gem 'letter_opener' # When mail is sent from your application, Letter Opener will open a preview in the browser instead of sending.
  gem 'railroady'
  gem 'rails-erd' # Automatically generate an entity-relationship diagram (ERD) for your Rails models.
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # gem 'solargraph'
end

group :test do
  gem 'chronic' # Chronic is a natural language date/time parser written in pure Ruby
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'email_spec' # Easily test email in RSpec, Cucumber, and MiniTest
  gem 'pundit-matchers'
  gem 'rails-controller-testing' # Extracting `assigns` and `assert_template` from ActionDispatch.
  gem 'shoulda-matchers'
  gem 'webdrivers' # Easy installation and use of web drivers to run system tests with browsers
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
