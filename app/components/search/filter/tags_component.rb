module Search
  module Filter
    class TagsComponent < ViewComponent::Base
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
        I18n.t('activerecord.attributes.book.tag_list')
      end

      # Stimulus
      def data_controller
        'tags'
      end

      def data_target
        "#{data_controller}-target"
      end
    end
  end
end
