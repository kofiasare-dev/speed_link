# frozen_string_literal: true

module Locateable
  extend ActiveSupport::Concern

  included do
    has_many :locations, as: :locateable, dependent: :destroy
  end

  def current_location
    lonlat = Cache.fetch("#{self.class.base_class}:#{id}", 30) { locations.last&.lonlat }

    lonlat.is_a?(String) ? Geo.wkt_to_point(lonlat) : lonlat
  end
end
