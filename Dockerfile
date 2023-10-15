FROM ruby:3.2.2
RUN apt-get update -qq && apt-get install -y postgresql-client vim
WORKDIR /app
ADD Gemfile /app/Gemfile
