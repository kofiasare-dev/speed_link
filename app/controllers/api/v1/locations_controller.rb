# frozen_string_literal: true

module Api
  module V1
    class LocationsController < ApplicationController
      def produce
        locateable = current_account.user
        lon = params.required(:lon)
        lat = params.required(:lat)

        Locations::Produce.run!(locateable:, lon:, lat:)

        head :accepted
      end
    end
  end
end
