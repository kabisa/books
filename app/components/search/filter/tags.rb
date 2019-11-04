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

      # Stimulus
      def data_controller
        'checkboxes'
      end
    end
  end
end
