# frozen_string_literal: true

class DriverChannel < ApplicationCable::Channel
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
