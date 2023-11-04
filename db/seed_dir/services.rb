# frozen_string_literal: true

services = [
  {
    name: 'Lite',
    description: 'Affordable ride experience',
    active: true,
    person_capacity: 1,
    config: {
      basic_fare_cents: 600,
      commission_cents: 2500,
      price_per_km_cents: 98,
      price_per_min_cents: 50
    }
  },
  {
    name: 'Comfort',
    description: 'Improved ride experience',
    active: true,
    person_capacity: 1,
    config: {
      basic_fare_cents: 1300,
      commission_cents: 2500,
      price_per_km_cents: 98,
      price_per_min_cents: 50
    }
  }
]

services.each do |service_definition|
  Service.find_or_create_by!(name: service_definition[:name]) do |s|
    s.build_active_config(service_definition.delete(:config))
    s.assign_attributes(service_definition)
  end
end
