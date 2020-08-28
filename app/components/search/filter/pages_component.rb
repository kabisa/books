module Search
  module Filter
    class PagesComponent < MultiHandleRange
      NUM_OF_PAGES_UPPER = BookSearch::NUM_OF_PAGES_UPPER

      def initialize(q:, builder:, live_search: false)
        super
      end

      private

      def max
        NUM_OF_PAGES_UPPER
      end

      def step
        25
      end

      def scope
        'pages'
      end
    end
  end
end
