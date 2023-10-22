# frozen_string_literal: true

module Accounts
  class Create < ApplicationInteraction
    interface :user, default: Rider.new
    string :phone
    string :email
    string :password

    def execute
      account = Account.new(inputs.merge(holder: user.type))
      account.build_profile

      errors.merge!(account.errors) unless account.save

      account
    end
  end
end
