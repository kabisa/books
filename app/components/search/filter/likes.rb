module Search
  module Filter
    class Likes < ViewComponent::Base
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

      def live_search?
        @live_search
      end

      def decorate_dataset(dataset = {})
        return dataset unless live_search? && dataset.has_key?(:action)

        dataset[:action] << ' search#perform'

        dataset
      end

      # Stimulus
      def data_controller
        'likes'
      end
    end
  end
end
