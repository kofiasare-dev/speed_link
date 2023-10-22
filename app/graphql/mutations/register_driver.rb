# frozen_string_literal: true

module Mutations
  class RegisterDriver < Base::Mutation
    requires_auth false

    argument :phone, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true

    def execute(*)
      account = create_account!

      maybe_update_driver_profile(profile: account.profile)

      # TODO: send otp for verification if account is not confirmed

      empty
    end

    private

    def create_account!
      Accounts::Create.run! user: Driver.new, phone:, email:, password:
    end

    def maybe_update_driver_profile(profile)
      # Profiles::Update.run!(profile: account.profile)
    end
  end
end
