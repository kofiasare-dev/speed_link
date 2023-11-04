# frozen_string_literal: true

module Types
  class DriverType < Base::Object
    field :state, String, null: false, method: :aasm_state
    field :trips, [TripType], null: true
    field :cabs, [CabType], null: true
    field :services, [ServiceType], null: true
  end
end
