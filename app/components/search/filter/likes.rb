module Search
  module Filter
    class Likes < ActionView::Component::Base
      def initialize(q:, builder:)
        @q = q
        @builder = builder
      end

      private

      attr_reader :q, :builder
      alias :f :builder

      def likes_count
        q.likes_count_gteq || 0
      end

      # Stimulus
      def data_controller
        'range-slider'
      end
    end
  end
end
