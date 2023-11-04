# frozen_string_literal: true

module Locations
  class Produce < ApplicationInteraction
    interface :locateable
    float :lat
    float :lon

    def execute
      topic = Topics::LOCATION_UPDATES
      payload = Location.new(locateable:, lonlat: Geo.point(lon:, lat:)).to_json(except: %i[id created_at])

      Karafka.producer.produce_async(topic:, payload:)
    end
  end
end
