# frozen_string_literal: true

module Base
  class Mutation < GraphQL::Schema::Mutation
    include Authorizable
    include Validateable
    include Errorable::Result

    def resolve(*args)
      check_auth!
      execute_mutation(args)
    rescue ActiveInteraction::InvalidInteractionError => e
      validation_error_response(e.interaction.errors.messages)
    rescue ResolverError => e
      error_response(e.message)
    end

    def method_missing(method_name, *args)
      if @arguments_by_keyword.key?(method_name)
        @execution_args[method_name]
      else
        super
      end
    end

    def respond_to_missing?(method_name, _include_private = false)
      @arguments_by_keyword.key?(method_name) || super
    end

    class << self
      def wrap_with_transaction(wrap)
        @wrap = wrap
      end

      def wrap_with_transaction?
        @wrap.nil? ? true : @wrap
      end
    end

    protected

    def current_account
      context[:current_account]
    end

    def empty = {}

    private

    def execute_mutation(args)
      @execution_args = args[0]

      if self.class.wrap_with_transaction?
        ActiveRecord::Base.transaction { execute(**@execution_args) || empty }
      else
        execute(**execute_mutation) || empty
      end
    end
  end
end
