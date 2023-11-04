# frozen_string_literal: true

# == Schema Information
#
# Table name: services
#
#  id              :bigint           not null, primary key
#  active          :boolean          default(FALSE), not null
#  description     :text
#  logo_data       :text
#  metadata        :jsonb            not null
#  name            :string           not null
#  person_capacity :integer          default(1), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_services_on_name  (name) UNIQUE
#
class Service < ApplicationRecord
  has_one :active_config, -> { where(active: true) }, class_name: 'ServiceConfig', autosave: true

  has_many :service_configs
  has_many :subscriptions
  has_many :drivers, through: :subscriptions

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
