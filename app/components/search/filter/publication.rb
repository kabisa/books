module Search
  module Filter
    class Publication < MultiHandleRange
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
    end
  end
end
