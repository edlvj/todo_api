source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.2'


gem 'fast_jsonapi'
gem 'rails', '~> 5.2.0'
gem 'pg'
gem 'puma', '~> 3.11'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'rack-cors', require: 'rack/cors'
gem 'jwt'
gem 'simple_command'
gem 'pundit'
gem 'acts_as_list'
gem 'aws-sdk-s3', require: false

gem 'grape'
gem 'grape-entity'

group :development, :test do
  gem 'mina', '0.3.0'
  gem 'mina-multistage', '1.0.2', require: false
  gem 'mina-puma', '0.3.2', require: false
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'rubocop', require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'simplecov', require: false
  gem 'rails-controller-testing'
  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 3.1'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
