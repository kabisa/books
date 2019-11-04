module Search
  module Filter
    class Dropdown < ActionView::Component::Base
      include BootstrapHelper

      def initialize(q:, builder:, title:, toggle_html: {})
        @q = q
        @builder = builder
        @title = title
        @toggle_html = toggle_html
      end

      private

      attr_reader :q, :builder, :title, :toggle_html
      alias :f :builder

      def dom_id
        [model_name.singular, object_id].join('-')
      end

      def toggle_options
        default_options = {
          class: 'btn btn-sm btn-outline dropdown-toggle',
          role: :button,
          id: dom_id,
          data: {
            toggle: :dropdown,
            flip: false,
            boundary: dom_id,
            offset: '0,10'
          }
        }

        default_options.deep_merge(toggle_html)
      end
    end
  end
end
