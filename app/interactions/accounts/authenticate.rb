# frozen_string_literal: true

module Accounts
  class Authenticate < BaseInteraction
    import_filters Jwt::Decode

    def execute
      payload = compose(Jwt::Decode, inputs)

      compose FindAccount, id: payload[0]['sub']
    end
  end
end
