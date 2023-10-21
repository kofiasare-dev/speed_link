# frozen_string_literal: true

class KarafkaApp < Karafka::App
  setup do |config|
    config.kafka = {
      'bootstrap.servers': ENV['KAFKA_HOST'],
      'compression.codec': 'gzip',
      'compression.level': '12'
    }
    config.client_id = 'speed_link'
    # Recreate consumers with each batch. This will allow Rails code reload to work in the
    # development mode. Otherwise Karafka process would not be aware of code changes
    config.consumer_persistence = !Rails.env.development?
  end

  # Comment out this part if you are not using instrumentation and/or you are not
  # interested in logging events for certain environments. Since instrumentation
  # notifications add extra boilerplate, if you want to achieve max performance,
  # listen to only what you really need for given environment.
  # Karafka.monitor.subscribe(Karafka::Instrumentation::LoggerListener.new)
  # Karafka.monitor.subscribe(Karafka::Instrumentation::ProctitleListener.new)

  # This logger prints the producer development info using the Karafka logger.
  # It is similar to the consumer logger listener but producer oriented.
  Karafka.producer.monitor.subscribe(
    WaterDrop::Instrumentation::LoggerListener.new(Karafka.logger, log_messages: false)
  )

  routes.draw do
    # Uncomment this if you use Karafka with ActiveJob
    # You need to define the topic per each queue name you use
    # active_job_topic :default
    topic :driver_location_updates do
      # Uncomment this if you want Karafka to manage your topics configuration
      # Managing topics configuration via routing will allow you to ensure config consistency
      # across multiple environments
      #
      # config(partitions: 2, 'cleanup.policy': 'compact')
      consumer DriverLocationUpdateConsumer
    end
  end
end

Karafka::Web.setup do |config|
  # You may want to set it per ENV. This value was randomly generated.
  config.ui.sessions.secret = '3abdb369e1396e7647c97b6bde6d90763d4f425eb4fa655f73855436198b3e21'
end

Karafka::Web.enable!
