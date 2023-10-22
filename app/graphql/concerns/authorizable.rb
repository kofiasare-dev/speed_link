# frozen_string_literal: true

module Authorizable
  extend ActiveSupport::Concern

  class UnaunthenticatedError < GraphQL::ExecutionError
    def to_h
      super.merge('extensions' => { 'code' => 'UNAUTHENTICATED' })
    end
  end

  def check_auth!
    return unless self.class.requires_auth?

    authenticate!
  end

  def authenticate!
    return if current_account.present?

    raise UnaunthenticatedError, 'Authentication Required'
  end

  class_methods do
    def requires_auth(requires_auth)
      @requires_auth = requires_auth
    end

    def requires_auth?
      @requires_auth.nil? ? true : @requires_auth
    end
  end
end
