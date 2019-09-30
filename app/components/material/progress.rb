module Material
  class Progress < ActionView::Component::Base
    def initialize(value:)
      @value = value
    end

    private

    attr_reader :value

    def value_now
      value[:now]
    end

    def value_min
      value.fetch(:min) { 0 }
    end

    def value_max
      value[:max]
    end

    def width
      return 0 if value_max.zero?

      100*value_now/value_max
    end
  end
end
