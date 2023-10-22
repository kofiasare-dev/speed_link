# frozen_string_literal: true

module Types
  class UserType < Base::Union
    possible_types RiderType, DriverType

    # Optional: if this method is defined, it will override `Schema.resolve_type`
    def self.resolve_type(object, _context)
      case object
      when Rider  then RiderType
      when Driver then DriverType
      end
    end
  end
end
