# frozen_string_literal: true

module Resolvers
  class Account < Base::Resolver
    type Types::AccountType, null: false

    def execute
      current_account
    end
  end
end
