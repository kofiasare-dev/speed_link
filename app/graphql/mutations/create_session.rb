# frozen_string_literal: true

module Mutations
  class CreateSession < Base::Mutation
    requires_auth false

    argument :holder, Enums::AccountHolderEnum, required: true
    argument :phone, String, required: true
    argument :password, String, required: true

    field :session, Types::SessionType, null: true

    def execute(*)
      account = resolve_account
      error! 'Invalid login details. Please try again' unless account

      error! 'Invalid login details. Please try again' unless account.authenticate(password)

      { session: Accounts::CreateSession.run!(account:) }
    end

    private

    def resolve_account
      Accounts::FindByPhone.run(holder:, phone:).result
    end
  end
end
