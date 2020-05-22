source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma'
# Use SCSS for stylesheets
gem 'sass-rails'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false
gem 'slim-rails' # Provides the generator settings required for Rails 3+ to use Slim
gem 'simple_form' # Forms made easy!
gem 'draper' # Draper adds an object-oriented layer of presentation logic to your Rails apps.
gem 'pundit' # Object oriented authorization for Rails applications
gem 'paranoia' # Paranoia is a re-implementation of acts_as_paranoid for Rails 3, 4, and 5, using much, much, much less code.
gem 'view_component' # View components for Rails, intended for upstreaming in Rails 6.1
gem 'ransack' # Object-based searching.
# acts-as-taggable-on is not yet compatible w/ Rails 6+. Until then use a customized version.
gem 'acts-as-taggable-on', github: 'mkilling/acts-as-taggable-on',branch: 'support-rails-6' # With ActsAsTaggableOn, you can tag a single model on several contexts, such as skills, interests, and awards. It also provides other advanced functionality
gem 'kaminari'
gem 'carrierwave', '~> 2.0'
gem 'fog-aws'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 4.0.0.beta'
  gem 'rspec-collection_matchers'
  gem 'factory_bot_rails' # factory_bot_rails provides integration between factory_bot and rails 4.2 or newer
  gem 'faker' # easily generate fake data: names, addresses, phone numbers, etc.
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'html2slim'
  gem 'letter_opener' # When mail is sent from your application, Letter Opener will open a preview in the browser instead of sending.
  gem 'rails-erd' # Automatically generate an entity-relationship diagram (ERD) for your Rails models.
  gem 'railroady'
  gem 'bullet' # help to kill N+1 queries and unused eager loading.
  gem 'solargraph'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'email_spec' # Easily test email in RSpec, Cucumber, and MiniTest
  gem 'rails-controller-testing' # Extracting `assigns` and `assert_template` from ActionDispatch.
  gem 'shoulda-matchers'
  gem 'pundit-matchers'
  gem 'chronic' # Chronic is a natural language date/time parser written in pure Ruby
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
