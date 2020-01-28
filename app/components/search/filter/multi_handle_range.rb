require 'book_search'

module Search
  module Filter
    # This is a base class to be used for rendering
    # a filter component with a multi-range slider.
    class MultiHandleRange < ActionView::Component::Base
      METHOD_MISSING = 'Please implement this method in your inheriting class.'

      def initialize(q:, builder:)
        @q = q
        @builder = builder
      end

      private

      attr_reader :q, :builder
      alias :f :builder

      def title
        I18n.t("search_form.#{scope}.title")
      end

      def range_field(method, target)
        options = {
          class: 'custom-range',
          min: 0,
          max: max,
          step: step,
          data: {
            target: "#{data_controller}.#{target}",
            action: "change->#{data_controller}#validate input->#{data_controller}#render"
          }
        }
        f.range_field method, options
      end

      def max
        raise METHOD_MISSING
      end

      def step
        1
      end

      def scope
        raise METHOD_MISSING
      end

      # Stimulus
      def data_controller
        scope
      end
    end
  end
end
