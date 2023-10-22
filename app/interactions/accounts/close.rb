# frozen_string_literal: true

module Accounts
  class Close < ApplicationInteraction
    object :account

    def execute
      account.close! if account.may_close?

      account
    end
  end
end
