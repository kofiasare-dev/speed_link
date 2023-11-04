# frozen_string_literal: true

module ApplicationCable
  class Channel < ActionCable::Channel::Base
    include Pundit::Authorization

    def subscribed
      stream_from "Account::#{account.id}"
    end

    def update_location(params)
      authorize(Location.new, :produce?, policy_class: LocationPolicy)

      locateable = account.user
      lon = params['lon']
      lat = params['lat']

      Locations::Produce.run!(locateable:, lon:, lat:)
    end

    protected

    def pundit_user
      account.user
    end
  end
end
