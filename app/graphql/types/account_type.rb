# frozen_string_literal: true

module Types
  class AccountType < Base::Object
    field :phone, String, null: false
    field :profile, Types::ProfileType, null: false
    field :me, Types::UserType, null: false, method: :user
  end
end
