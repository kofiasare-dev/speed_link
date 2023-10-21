# frozen_string_literal: true

module Jwt
  class BaseInteraction < ApplicationInteraction
    protected

    def secret
      Rails.application.credentials.secret_key_base
    end

    def algorithm
      'HS256'
    end
  end
end
