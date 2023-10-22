# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  aasm_state :string
#  metadata   :jsonb            not null
#  type       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint
#
# Indexes
#
#  index_users_on_account_id           (account_id)
#  index_users_on_account_id_and_type  (account_id,type) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Driver < User
  include AASM

  has_one :active_cab, -> { where(active: true).first }, class_name: 'Cab'

  has_many :subscriptions
  has_many :services, through: :subscriptions
  has_many :cabs
  has_many :trips

  aasm whinny_persistence: true do
    state :offline, initial: true
    state :online

    event :go_online do
      transitions from: :offline, to: :online
    end

    event :go_offline do
      transitions from: :online, to: :offline
    end
  end
end
