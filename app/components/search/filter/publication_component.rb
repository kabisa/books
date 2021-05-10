module Search
  module Filter
    class PublicationComponent < MultiHandleRangeComponent
      PUBLISHED_YEARS_AGO_UPPER = BookSearch::PUBLISHED_YEARS_AGO_UPPER

      def initialize(q:, builder:, live_search: false)
        super
      end

      private

      def max
        PUBLISHED_YEARS_AGO_UPPER
      end

      def scope
        'publication'
      end

      def data_target
        "#{data_controller}-target"
      end
    end
  end
end
