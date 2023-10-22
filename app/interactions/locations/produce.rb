# frozen_string_literal: true

module Locations
  class Produce < ApplicationInteraction
    interface :locateable
    float :lat
    float :lon

    def execute
      payload = Location.new locateable:, lonlat: Geo.point(lon:, lat:)
      Karafka.producer.produce_async(
        topic: Topics::DRIVER_LOCATION_UPDATE,
        payload: payload.to_json(except: %i[id created_at])
      )
    end
  end
end
