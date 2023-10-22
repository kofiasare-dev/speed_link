# frozen_string_literal: true

module Validateable
  extend ActiveSupport::Concern

  included do
    include Errorable
  end

  class ResolverValidationError < Errorable::ResolverError; end

  def add_validation_error(field, message)
    errors.push(field:, message:)
  end

  def validation_error_response(errors = [], message: 'Validation errors occured')
    fields = []
    errors.each do |field, error_messages = []|
      error_messages.each do |msg|
        fields.push(field:, message: msg)
      end
    end

    self.errors.each do |error|
      fields.push(field: error[:field], message: error[:message])
    end

    { error: { message:, fields: } }
  end
end
