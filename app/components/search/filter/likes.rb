module Search
  module Filter
    class Likes < ActionView::Component::Base
      include BootstrapHelper
      def initialize(q:, builder:)
        @q = q
        @builder = builder
      end

      private

      attr_reader :q, :builder
      alias :f :builder

      def dom_id
        [model_name.singular, object_id].join('-')
      end

      def likes_count
        q.likes_count_gteq || 0
      end

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
