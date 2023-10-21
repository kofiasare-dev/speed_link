# frozen_string_literal: true

module Services
  class Create < ApplicationInteraction
    string :name
    string :description, default: nil
    integer :person_capacity, default: 4

    def execute
      service = Service.new(inputs)

      errors.merge!(service.errors) unless service.save

      service
    end
  end
end
