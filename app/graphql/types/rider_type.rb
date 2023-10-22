# frozen_string_literal: true

module Types
  class RiderType < Base::Object
    field :firstname, String, null: false
    field :othernames, String, null: false
  end
end
