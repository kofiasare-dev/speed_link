# frozen_string_literal: true

module Example
  class Square < ApplicationInteraction
    array :z, desc: 'The floating point number to be squared'

    def execute
      z.map { |i| i**2 }
    end
  end

  class SayHello < ApplicationInteraction
    string :name

    validates_presence_of :name

    def execute
      "Hello #{name}!"
    end
  end

  class ArrayInteraction < ApplicationInteraction
    array :toppings do
      string
    end

    def execute
      toppings.size
    end
  end

  class TestInteraction < ApplicationInteraction
    array :users, index_errors: true do
      object class: Driver
    end

    def execute
      users
    end
  end

  class FileInteraction < ApplicationInteraction
    file :readme

    def execute
      readme.size
    end
  end

  class HashInteraction < ApplicationInteraction
    hash :preferences do
      boolean :newsletter
      boolean :sweepstakes
    end

    def execute
      ap 'Thanks for joining the newsletter!' if preferences[:newsletter]
      ap 'Good luck in the sweepstakes!' if preferences[:sweepstakes]
    end
  end

  # Advance Interactions
  class InterfaceInteration < ApplicationInteraction
    interface :serializer,  methods: %i[dump load]

    def execute
      input = '{ "is_json" : true }'
      object = serializer.load(input)
      serializer.dump(object)
    end
  end

  class ObjectInteraction < ApplicationInteraction
    object :account

    def to_model
      Account.new
    end

    def execute
      account.profile
    end
  end

  class Add < ApplicationInteraction
    integer :x, :y

    def execute
      x + y
    end
  end

  class AddThree < ApplicationInteraction
    integer :x

    def execute
      compose(Add, x:, y: 3)
    end
  end

  class AddAndDouble < ApplicationInteraction
    import_filters Add

    def execute
      compose(Add, inputs) * 2
    end
  end
end
