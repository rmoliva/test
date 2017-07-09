# encoding: utf-8
# frozen_string_literal: true

source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.8'
# Use mysql as the database for Active Record
# gem 'mysql2', '>= 0.3.13', '< 0.5'
gem 'sqlite3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
# Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem 'less-rails'
gem 'twitter-bootstrap-rails'

gem 'haml'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Ruby gem for colorizing printed text on ANSI terminals
gem 'rainbow'

# Use Puma as the app server
gem 'puma'

# Active Record's Session Store extracted from Rails
gem 'activerecord-session_store'
# Restrict the values assignable to ActiveRecord attributes or associations
gem 'assignable_values'
# Authlogic is a clean, simple, and unobtrusive ruby authentication solution
gem 'authlogic'
# Pretty print your Ruby objects with style -- in full color and with proper
# indentation
gem 'awesome_print'
# A Scope & Engine based, clean, powerful, customizable and sophisticated
# paginator for Rails 3 and 4
gem 'kaminari'
# Track changes to your models, for auditing or versioning. See how a model
# looked at any stage in its lifecycle, revert it to any version, or restore
# it after it has been destroyed.
gem 'paper_trail'
# Logs the source of execution of all queries to the Rails log
gem 'active_record_query_trace'
# Map incoming controller parameters to named scopes in your resources
gem 'ransack', github: 'activerecord-hackery/ransack'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger
  # console
  gem 'byebug'
  # Strategies for cleaning databases in Ruby. Can be used to ensure a clean
  # state for testing
  gem 'database_cleaner'
  # A library for generating fake data such as names, addresses, and phone
  # numbers.
  gem 'faker'
  # Machinist makes it easy to create objects for use in tests. It generates
  # data for the attributes you don't care about, and constructs any necessary
  # associated objects, leaving you to specify only the fields you care about
  # in your test
  gem 'rspec'
  # rspec-rails is a testing framework for Rails 3.x and 4.x.
  gem 'rspec-rails', '~> 3.4'
  # Makes tests easy on the fingers and the eyes
  gem 'shoulda'
  # Code coverage for Ruby 1.9+ with a powerful configuration library and
  # automatic merging of coverage across test suites
  gem 'simplecov', require: false
end

gem 'machinist'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'rdoc'
  # A Ruby static code analyzer, based on the community Ruby style guide
  gem 'rubocop', require: false
end
