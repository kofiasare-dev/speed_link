# frozen_string_literal: true

module Types
  module NodeType
    include Base::Interface
    # Add the `id` field
    include GraphQL::Types::Relay::NodeBehaviors
  end
end
