# frozen_string_literal: true

module Jwt
  class Decode < BaseInteraction
    string :token

    def execute
      JWT.decode(token, secret, true, { algorithm: })
    rescue JWT::VerificationError
      errors.add(:token, :invalid_signature)
    rescue JWT::ExpiredSignature
      errors.add(:token, :expired)
    rescue JWT::InvalidAudError
      errors.add(:token, :invalid_aud)
    rescue JWT::DecodeError
      errors.add(:token, :invalid)
    end
  end
end
