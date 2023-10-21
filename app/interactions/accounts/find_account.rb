# frozen_string_literal: true

module Accounts
  class FindAccount < BaseInteraction
    integer :id

    def execute
      account = Account.active.includes(:user, :profile).find_by(id:)

      errors.add(:account, 'does not exist') unless account

      account
    end
  end
end
