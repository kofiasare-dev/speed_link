# frozen_string_literal: true

module Jwt
  class Encode < BaseInteraction
    string :sub
    string :aud
    time   :exp, default: 1.day.from_now

    def execute
      payload = { sub:, aud:, exp: exp.utc.to_i }

      JWT.encode payload, secret, algorithm
    end
  end
end
