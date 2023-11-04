# frozen_string_literal: true

class LocationPolicy < ApplicationPolicy
  def produce?
    user.is_a? Driver
  end

  # class Scope < Scope
  #   # NOTE: Be explicit about which records you allow access to!
  #   def resolve
  #     scope.all
  #   end
  # end
end
