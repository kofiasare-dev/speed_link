# frozen_string_literal: true

module Errorable
  class ResolverError < StandardError; end

  def errors
    @errors ||= []
  end

  def error!(message)
    raise ResolverError, message
  end

  def error_response(message)
    { error: { message: } }
  end

  module Result
    extend ActiveSupport::Concern

    included do
      field :error, Types::ErrorType, null: true
    end
  end
end
