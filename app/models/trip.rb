# frozen_string_literal: true

# == Schema Information
#
# Table name: trips
#
#  id           :bigint           not null, primary key
#  aasm_state   :string           default("pending"), not null
#  cancelled_at :datetime
#  ended_at     :datetime         not null
#  metadata     :jsonb            not null
#  name         :string
#  started_at   :datetime         not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  cab_id       :bigint           not null
#  driver_id    :bigint           not null
#  rider_id     :bigint           not null
#  service_id   :bigint           not null
#
# Indexes
#
#  index_trips_on_cab_id      (cab_id)
#  index_trips_on_driver_id   (driver_id)
#  index_trips_on_rider_id    (rider_id)
#  index_trips_on_service_id  (service_id)
#
# Foreign Keys
#
#  fk_rails_...  (cab_id => cabs.id)
#  fk_rails_...  (driver_id => users.id)
#  fk_rails_...  (rider_id => users.id)
#  fk_rails_...  (service_id => services.id)
#
class Trip < ApplicationRecord
  include AASM
  include ScatterSwappable

  belongs_to :rider, class_name: 'User'
  belongs_to :driver, class_name: 'User'
  belongs_to :cab
  belongs_to :service

  with_options class_name: 'Location', dependent: :destroy do
    has_one :pick_point
    has_one :dest_point

    has_many :stop_points, -> { order(position: :asc) }, inverse_of: :location
  end

  validates :started_at, presence: true

  aasm do
    state :pending, initial: true
    state :started
    state :cancelled_by_driver
    state :cancelled_by_rider
    state :completed
  end
end
