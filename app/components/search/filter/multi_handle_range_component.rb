require 'book_search'

module Search
  module Filter
    # This is a base class to be used for rendering
    # a filter component with a multi-range slider.
    class MultiHandleRangeComponent < ViewComponent::Base
      include LiveSearchable
      METHOD_MISSING = 'Please implement this method in your inheriting class.'

      def initialize(q:, builder:, live_search: false)
        @q = q
        @builder = builder
        @live_search = live_search
      end

      private

      attr_reader :q, :builder
      alias f builder

      def title
        I18n.t("search_form.#{scope}.title")
      end

      def range_field(method, target)
        options = {
          class: 'custom-range',
          min: 0,
          max: max,
          step: step,
          data: range_field_dataset(target)
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

      def range_field_dataset(target)
        decorate_dataset(
          target: "#{data_controller}.#{target}",
          action:
            "change->#{data_controller}#validate input->#{
              data_controller
            }#render"
        )
      end

      # Stimulus
      def data_controller
        scope
      end
    end
  end
end
