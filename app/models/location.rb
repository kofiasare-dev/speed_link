# frozen_string_literal: true

# == Schema Information
#
# Table name: locations
#
#  id              :bigint           not null, primary key
#  latlon          :geography        point, 4326
#  locateable_type :string
#  metadata        :jsonb            not null
#  position        :integer
#  created_at      :datetime         not null
#  locateable_id   :bigint
#
# Indexes
#
#  index_locations_on_locateable  (locateable_type,locateable_id)
#
class Location < ApplicationRecord
  belongs_to :locateable, polymorphic: true

  validates :latlon, presence: true
end
