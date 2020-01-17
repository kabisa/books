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
