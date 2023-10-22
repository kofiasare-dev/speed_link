# frozen_string_literal: true

module Rescuable
  extend ActiveSupport::Concern

  included do
    rescue_from Errors::UnauthenticatedError do
      render json: { error: 'Authentication required' }, status: :unauthorized
    end

    rescue_from ActionController::ParameterMissing do |e|
      render json: { error: e }, status: :bad_request
    end
  end
end
