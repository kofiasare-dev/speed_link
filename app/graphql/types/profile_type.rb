# frozen_string_literal: true

module Types
  class ProfileType < Base::Object
    field :firstname, String, null: true
    field :othernames, String, null: true
  end
end
