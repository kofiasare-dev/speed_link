# frozen_string_literal: true

module Base
  class Resolver < GraphQL::Schema::Resolver
    include Authorizable

    def resolve(*args)
      check_auth!
      execute_resolver(*args)
    end

    protected

    def current_account
      context[:current_account]
    end

    def empty = {}

    private

    def execute_resolver(*args)
      execute(*args)
    end
  end
end
