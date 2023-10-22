# frozen_string_literal: true

module Mutations
  class RegisterRider < Base::Mutation
    requires_auth false

    argument :phone, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true

    def execute(*)
      Accounts::Create.run!(phone:, email:, password:)

      empty
    end
  end
end
