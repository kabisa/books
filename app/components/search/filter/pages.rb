require 'book_search'

module Search
  module Filter
    class Pages < ActionView::Component::Base
      def initialize(q:, builder:)
        @q = q
        @builder = builder
      end

      private

      attr_reader :q, :builder
      alias :f :builder

      def title
        I18n.t('search_form.pages.title')
      end

      def range_field(method, target)
        options = {
          class: 'custom-range',
          min: 0,
          max: num_of_pages_upper,
          step: 25,
          data: {
            target: "#{data_controller}.#{target}",
            action: "change->#{data_controller}#validate input->#{data_controller}#render"
          }
        }
        f.range_field method, options
      end

      def num_of_pages_upper
        BookSearch::NUM_OF_PAGES_UPPER
      end

      # Stimulus
      def data_controller
        'pages'
      end
    end
  end
end
