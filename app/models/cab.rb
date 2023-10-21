# frozen_string_literal: true

# == Schema Information
#
# Table name: cabs
#
#  id            :bigint           not null, primary key
#  active        :boolean          default(FALSE)
#  approved      :boolean          default(FALSE)
#  color         :string           not null
#  license_plate :string           not null
#  make          :string           not null
#  model         :string           not null
#  seats         :integer          default(4), not null
#  year          :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  driver_id     :bigint           not null
#
# Indexes
#
#  index_cabs_on_driver_id                    (driver_id)
#  index_cabs_on_driver_id_and_license_plate  (driver_id,license_plate) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (driver_id => users.id)
#
class Cab < ApplicationRecord
  # The maximum age of an eligible vehicle in years.
  ELIGIBLE_VEHICLE = 15.years

  belongs_to :driver

  validates :make, presence: true
  validates :model, presence: true
  validates :year, presence: true
  validates :color, presence: true
  validates :license_plate, presence: true
  validates :year, presence: true
  validates :year, numericality: { less_than_or_equal_to: Date.current.year - ELIGIBLE_VEHICLE }
  validates :license_plate, uniqueness: { case_sensitive: false, scope: [:driver] }
end
