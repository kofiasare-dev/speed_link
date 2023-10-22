# frozen_string_literal: true

module Types
  class QueryType < Base::Object
    field :account, resolver: Resolvers::Account, null: false
  end
end
