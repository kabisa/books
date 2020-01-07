module Search
  module Filter
    class MyLikes < ActionView::Component::Base
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
        'Likes'
      end

      # Stimulus
      def data_controller
        'my-likes'
      end
    end
  end
end
