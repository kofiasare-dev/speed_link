# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit::Authorization
  include Authenticateable
  include Rescuable

  before_action :authenticate_account!
  around_action :scan_n_plus_one, if: :development?

  private

  def scan_n_plus_one
    Prosopite.scan
    yield
  ensure
    Prosopite.finish
  end

  def development?
    Rails.env.development?
  end

  def log(message, level: :debug, logger: Rails.logger)
    logger.send(level, message)
  end
end
