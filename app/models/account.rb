# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id              :bigint           not null, primary key
#  aasm_state      :string           default("active"), not null
#  email           :string           not null
#  holder          :string           default("Rider"), not null
#  metadata        :jsonb            not null
#  password_digest :string           not null
#  phone           :string           not null
#  verified_at     :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_accounts_on_aasm_state        (aasm_state)
#  index_accounts_on_email             (email)
#  index_accounts_on_holder            (holder)
#  index_accounts_on_phone             (phone)
#  index_accounts_on_phone_and_holder  (phone,holder) UNIQUE WHERE ((aasm_state)::text = ANY ((ARRAY['active'::character varying, 'inactive'::character varying])::text[]))
#
class Account < ApplicationRecord
  include AASM
  include ScatterSwappable

  normalizes :email, with: ->(email) { email.downcase.strip }

  has_secure_password :password, validations: false

  has_one :user, dependent: :destroy, autosave: true
  has_one :profile, dependent: :destroy, autosave: true

  validates :password, presence: true, on: :create
  validates :holder, inclusion: { in: %w[Rider Driver] }
  validates :phone, presence: true, phone: true
  validates :email, presence: true
  validates :phone, uniqueness: { scope: :holder, conditions: -> { where(aasm_state: %i[active inactive]) } }

  aasm whinny_persistence: true do
    state :active, initial: true
    state :inactive
    state :closed

    event :close do
      transitions from: %i[active inactive], to: :closed
    end

    event :deactivate do
      transitions from: :active, to: :inactive
    end

    event :activate do
      transitions from: :inactive, to: :active
    end
  end
end
