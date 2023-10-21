# frozen_string_literal: true

class ApplicationController < ActionController::API
  class UnauthenticatedError < StandardError; end

  rescue_from UnauthenticatedError do |_e|
    render json: { error: 'Authentication required' }, status: :unauthorized
  end

  rescue_from ActionController::ParameterMissing do |e|
    render json: { error: e }, status: :bad_request
  end
end
