# frozen_string_literal: true

# == Schema Information
#
# Table name: subscriptions
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  driver_id  :bigint           not null
#  service_id :bigint           not null
#
# Indexes
#
#  index_subscriptions_on_driver_id                 (driver_id)
#  index_subscriptions_on_driver_id_and_service_id  (driver_id,service_id) UNIQUE
#  index_subscriptions_on_service_id                (service_id)
#
# Foreign Keys
#
#  fk_rails_...  (driver_id => users.id)
#  fk_rails_...  (service_id => services.id)
#
class Subscription < ApplicationRecord
  belongs_to :driver
  belongs_to :service

  validates :driver, uniqueness: { case_sensitive: false, scope: :service }
end
