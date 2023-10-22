# frozen_string_literal: true

module Accounts
  class CreateSession < BaseInteraction
    object :account

    def execute
      { session_token:, refresh_token: }
    end

    private

    def session_token
      compose Jwt::Encode, sub: account_id, aud: 'session'
    end

    def refresh_token
      compose Jwt::Encode, sub: account_id, aud: 'refresh', exp: 1.month.from_now
    end

    def account_id
      account.id.to_s
    end
  end
end
