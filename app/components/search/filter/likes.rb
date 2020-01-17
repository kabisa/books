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
