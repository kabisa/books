module Search
  module Filter
    class Tags < ActionView::Component::Base
      def initialize(q:, builder:)
        @q = q
        @builder = builder
      end

      private

      attr_reader :q, :builder
      alias :f :builder

      def title
        I18n.t('activerecord.attributes.book.tag_list')
      end

      # Stimulus
      def data_controller
        'tags'
      end
    end
  end
end
