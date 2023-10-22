# frozen_string_literal: true

module Api
  module V1
    class GraphController < ApplicationController
      skip_before_action :authenticate_account!, only: :execute

      def execute
        log query
        execute_schema
      rescue StandardError => e
        raise e unless development?

        handle_error_in_development e
      end

      protected

      def execute_schema
        render json: ApiSchema.execute(query, variables:, context:, operation_name:)
      end

      def query
        params[:query]
      end

      def variables
        @variables ||= prepare_variables params[:variables]
      end

      def context
        @context ||= { current_account: }
      end

      def operation_name
        @operation_name ||= params[:operationName]
      end

      # Handle variables in form data, JSON body, or a blank value
      def prepare_variables(variables_param)
        case variables_param
        when String
          variables_param.present? ? JSON.parse(variables_param) || {} : {}
        when Hash
          variables_param
        when ActionController::Parameters
          variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
        when nil
          {}
        else
          raise ArgumentError, "Unexpected parameter: #{variables_param}"
        end
      end

      def handle_error_in_development(e)
        log e.message, level: :error
        log e.backtrace.join("\n"), level: :error

        render(
          status: :internal_server_error,
          json: {
            errors: [{ message: e.message, backtrace: e.backtrace }],
            data: {}
          }
        )
      end
    end
  end
end
