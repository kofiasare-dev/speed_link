# frozen_string_literal: true

require 'sidekiq'

Sidekiq.strict_args!(false)

Rails.application.config.to_prepare do
  Sidekiq.configure_client do |config|
    config.redis = { url: ENV['REDIS_HOST'] }
  end

  Sidekiq.configure_server do |config|
    config.redis = { url: ENV['REDIS_HOST'] }

    config.on(:startup) do
      ::Karafka::Embedded.start
    end

    config.on(:shutdown) do
      ::Karafka::Embedded.stop
    end
  end
end
