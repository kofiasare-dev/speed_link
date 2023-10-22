# frozen_string_literal: true

module Accounts
  class FindByPhone < BaseInteraction
    string :holder, default: 'Rider'
    string :phone

    def execute
      account = find_account!

      errors.add(:account, 'does not exist') unless account

      account
    end

    private

    def find_account!
      active_accounts = Account.active.includes :user, :profile

      active_accounts.find_by(holder:, phone:)
    end
  end
end
