# frozen_string_literal: true

module Api
  module V1
    class LocationsController < BaseController
      def create
        Locations::Create.run! driver:, location:
      end

      private

      def driver
        current_account.user
      end

      def location
        { lat: params.required(:lat), lon: params.required(:lon) }
      end
    end
  end
end
