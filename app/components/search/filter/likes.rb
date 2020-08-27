module Search
  module Filter
    class Likes < ViewComponent::Base
      include LiveSearchable

      def initialize(q:, builder:, live_search: false)
        @q = q
        @builder = builder
        @live_search = live_search
      end

      private

      attr_reader :q, :builder
      alias f builder

      def title
        I18n.t('activerecord.attributes.book.likes_count')
      end

      # Stimulus
      def data_controller
        'likes'
      end
    end
  end
end
