# frozen_string_literal: true

class Trip < ApplicationRecord
  include AASM
  include ScatterSwappable

  belongs_to :rider, class_name: 'User'
  belongs_to :driver, class_name: 'User'
  belongs_to :cab
  belongs_to :service

  has_one :pick_point, as: :locateable, dependent: :destroy
  has_one :destination_point, as: :locateable, dependent: :destroy

  has_many :stop_points, -> { order(position: :asc) }, as: :locateable, dependent: :destroy

  validates :started_at, presence: true

  aasm do
    state :pending, initial: true
    state :started
    state :cancelled_by_driver
    state :cancelled_by_rider
    state :completed
  end
end
