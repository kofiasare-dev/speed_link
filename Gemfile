# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 3.2.2'

gem 'rails', '7.1.0'

gem 'aasm'
gem 'active_interaction', '~> 5.3'
gem 'activerecord-postgis-adapter', '~> 9.0'
gem 'bootsnap', require: false
gem 'karafka'
gem 'karafka-web'
gem 'pg', '~> 1.1'
gem 'puma', '6.0'
gem 'rack-cors'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

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

group :github do
  gem 'plutonium_generators', git: 'https://github.com/plutonium-rails/plutonium-generators'
end
