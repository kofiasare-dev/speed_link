# frozen_string_literal: true

module Authenticateable
  AUTHORIZATION_KEY = 'Authorization'

  protected

  def authenticate_account!
    raise Errors::UnauthenticatedError unless current_account
  end

  def current_account
    @current_account ||= begin
      token && Accounts::Authenticate.run!(token:) || nil
    rescue ActiveInteraction::InvalidInteractionError
      nil
    end
  end

  def authenticated?
    !current_account.nil?
  end

  def verified?
    !current_account&.verified_at.nil?
  end

  def token
    return headers[AUTHORIZATION_KEY].split("\s").last if headers[AUTHORIZATION_KEY].present?

    nil
  end

  def headers
    request.headers
  end
end
