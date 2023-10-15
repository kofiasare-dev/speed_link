# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 3.2.2'

gem 'rails', '7.1.0.rc1'

gem 'bootsnap', require: false
gem 'pg', '~> 1.1'
gem 'puma', '6.0'
gem 'rack-cors'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :github do
  gem 'plutonium_generators', git: 'https://github.com/plutonium-rails/plutonium-generators'
end

group :development do
  gem 'annotate'
  gem 'awesome_print'
  gem 'prosopite'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
end

group :development, :test do
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'spring'
end
