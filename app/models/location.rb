# frozen_string_literal: true

# == Schema Information
#
# Table name: locations
#
#  id              :bigint           not null, primary key
#  locateable_type :string
#  lonlat          :geography        not null, point, 4326
#  metadata        :jsonb            not null
#  position        :integer
#  created_at      :datetime         not null
#  locateable_id   :bigint
#
# Indexes
#
#  index_locations_on_locateable  (locateable_type,locateable_id)
#  index_locations_on_lonlat      (lonlat) USING gist
#
class Location < ApplicationRecord
  belongs_to :locateable, polymorphic: true

  validates :lonlat, presence: true

  class << self
    def cache_all!(locations)
      ActiveRecord::Base.transaction do
        cache_locations!(locations, ex: 30) { insert_all!(locations) }
      end
    end

    private

    def cache_locations!(locations, ex: nil)
      updates = {}
      locations.each { |l| updates["#{l['locateable_type']}:#{l['locateable_id']}"] = l['lonlat'] }

      Cache.redis.multi do |tx|
        tx.mset(*updates.to_a.flatten)
        updates.each_key { |k| tx.expire(k, ex) } if ex
      end

      yield if block_given?
    rescue Redis::BaseError => e
      raise e
    end
  end
end
