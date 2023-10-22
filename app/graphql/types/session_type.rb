# frozen_string_literal: true

module Types
  class SessionType < Base::Object
    field :session_token, String, null: false
    field :refresh_token, String, null: false
  end
end
