module Material
  # See http://daemonite.github.io/material/docs/4.1/components/progress/
  class Progress < ViewComponent::Base
    def initialize(value:, background: nil, html: {})
      @value = value
      @background = background
      @html_options = html
    end

    private

    attr_reader :value, :background, :html_options

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

    def progressbar_class
      progressbar_class = %w(progress-bar)
      progressbar_class << "bg-#{background}" if background
      progressbar_class
    end
  end
end
