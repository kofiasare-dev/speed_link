# frozen_string_literal: true

class UpdateLocateableLocationConsumer < ApplicationConsumer
  def consume
    Location.cache_all! messages.payloads
  end

  def revoked; end

  def shutdown; end
end
