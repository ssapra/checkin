source 'https://rubygems.org'
ruby "2.0.0"

gem 'rack-cors'
gem 'pg'
gem 'activerecord', '~> 4.0.0', :require => 'active_record'
gem 'honeybadger'
gem 'json'
gem 'napa', :git => "https://github.com/ssapra/napa"
gem 'roar'
gem 'grape-swagger'
gem 'valid_email'

group :development,:test do
  gem 'pry'
end

group :development do
  gem 'rubocop', require: false
  gem 'shotgun', require: false
end

group :test do
  gem 'factory_girl'
  gem 'rspec'
  gem 'rack-test'
  gem 'simplecov'
  gem 'webmock'
  gem 'database_cleaner'
  gem 'faker'
end
