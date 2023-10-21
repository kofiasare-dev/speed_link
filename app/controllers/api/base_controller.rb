# frozen_string_literal: true

module Api
  class BaseController < ApplicationController
    AUTHORIZATION_KEY = 'Authorization'

    before_action :authenticate_account!

    protected

    def authenticate_account!
      raise UnauthenticatedError unless current_account
    end

    def current_account
      @current_account ||= begin
        token && Accounts::Authenticate.run!(token:) || nil
      rescue ActiveInteraction::InvalidInteractionError
        nil
      end
    end

    def token
      return headers[AUTHORIZATION_KEY].split("\s").last if headers[AUTHORIZATION_KEY].present?

      nil
    end

    def headers
      request.headers
    end
  end
end
