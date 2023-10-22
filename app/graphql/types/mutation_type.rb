# frozen_string_literal: true

module Types
  class MutationType < Base::Object
    field :register_driver, mutation: Mutations::RegisterDriver, null: false
    field :register_rider, mutation: Mutations::RegisterRider, null: false
    field :create_session, mutation: Mutations::CreateSession, null: false
  end
end
