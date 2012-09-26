source 'https://rubygems.org'

ruby '1.9.2'

gem 'rails', '3.2.8'
gem 'pg'
gem 'thin'
gem 'devise', '~> 2.1.2'
gem 'jquery-rails'
gem 'twitter-bootstrap-rails', '~> 2.1.3'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
  gem 'rspec-rails', '~> 2.11.0'
  gem 'capybara', '~> 1.1.2'
  gem 'capybara-webkit', '~> 0.12.1'
  gem 'poltergeist', '~> 0.6.0'
  gem 'launchy', '~> 2.1.0'
  gem 'factory_girl_rails', '~> 3.5.0'
  gem 'spork-rails', '~> 3.2.0'
  gem 'sqlite3'
  gem 'database_cleaner'
  gem 'valid_attribute'
end

group :development do
  gem 'heroku'
end