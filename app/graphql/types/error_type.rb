# frozen_string_literal: true

module Types
  class ErrorType < Base::Object
    class FieldErrorType < Base::Object
      field :field, String, null: false
      field :message, String, null: false
    end

    field :message, String, null: false
    field :fields, [FieldErrorType], null: true
  end
end
