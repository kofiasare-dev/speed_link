# frozen_string_literal: true

# == Schema Information
#
# Table name: service_configs
#
#  id                  :bigint           not null, primary key
#  active              :boolean          default(FALSE), not null
#  basic_fare_cents    :integer          default(0), not null
#  commission_cents    :integer          default(1000), not null
#  price_per_km_cents  :integer          default(0), not null
#  price_per_min_cents :integer          default(0), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  service_id          :bigint
#
# Indexes
#
#  index_service_configs_on_service_id  (service_id)
#
# Foreign Keys
#
#  fk_rails_...  (service_id => services.id)
#
class ServiceConfig < ApplicationRecord
  belongs_to :service

  with_options numericality: { only_integer: true, greater_than_equal: 0 } do
    validates :basic_fare_cents
    validates :price_per_km_cents
    validates :price_per_min_cents
    validates :commission_cents
  end
end
