# frozen_string_literal: true

module Accounts
  class Create < ApplicationInteraction
    string :phone
    string :email
    string :password

    def execute
      account = Account.new(inputs)

      errors.merge!(account.errors) unless account.save

      account
    end
  end
end
