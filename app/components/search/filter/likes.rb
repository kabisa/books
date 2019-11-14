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

      def zero_items_classnames
        class_names = %w(zero-items)
        class_names << 'd-none' if likes_count.nonzero?
        class_names
      end

      def other_items_classnames
        class_names = %w(other-items)
        class_names << 'd-none' if likes_count.zero?
        class_names
      end

      # Stimulus
      def data_controller
        'range-slider'
      end
    end
  end
end
