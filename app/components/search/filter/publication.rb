require 'book_search'

module Search
  module Filter
    class Publication < ActionView::Component::Base
      PUBLISHED_YEARS_AGO_UPPER = BookSearch::PUBLISHED_YEARS_AGO_UPPER

      def initialize(q:, builder:)
        @q = q
        @builder = builder
      end

      private

      attr_reader :q, :builder
      alias :f :builder

      def title
        I18n.t('search_form.publication.title')
      end

      def range_field(method, target)
        options = {
          class: 'custom-range',
          min: 0,
          max: published_years_ago_upper,
          step: 1,
          data: {
            target: "#{data_controller}.#{target}",
            action: "change->#{data_controller}#validate input->#{data_controller}#render"
          }
        }
        f.range_field method, options
      end

      def published_years_ago_upper
        PUBLISHED_YEARS_AGO_UPPER
      end

      # Stimulus
      def data_controller
        'publication'
      end
    end
  end
end
