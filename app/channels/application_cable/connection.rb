# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include Authenticateable

    identified_by :account

    def connect
      reject_unauthorized_connection unless authenticated? && verified?

      self.account = current_account
    end

    def disconnect
      account.user.go_offline! if account.user.try(:may_go_offline?)
    end
  end
end
