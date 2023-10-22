# frozen_string_literal: true

class ApiSchema < Base::Schema
  mutation Types::MutationType
  query Types::QueryType
end
