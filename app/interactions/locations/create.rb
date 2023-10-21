# frozen_string_literal: true

module Locations
  class Create < ApplicationInteraction
    KAFKA_TOPIC = 'driver_location_updates'

    object :driver
    hash :location do
      float :lat
      float :lon
    end

    def execute
      payload = Location.new(locateable: driver, latlon: location).to_json

      Karafka.producer.produce_async(topic: KAFKA_TOPIC, payload:)
    end
  end
end
