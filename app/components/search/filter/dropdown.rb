module Search
  module Filter
    class Dropdown < ActionView::Component::Base
      include BootstrapHelper
      validates :content, :title, presence: true

      def initialize(title:, toggle_html: {})
        @title = title
        @toggle_html = toggle_html
      end

      private

      attr_reader :title, :toggle_html

      def dom_id
        [model_name.singular, object_id].join('-')
      end

      def toggle_options
        default_options.deep_merge(toggle_html) do |key, this_val, other_val|
          [this_val, other_val].join(' ').strip
        end
      end

      def default_options
        {
          class: 'btn btn-sm btn-outline dropdown-toggle',
          role: :button,
          id: dom_id,
          data: {
            target: "#{data_controller}.#{toggle_target}",
            toggle: :dropdown,
            flip: false,
            boundary: dom_id,
            offset: '0,10'
          }
        }
      end

      # Stimulus
      def data_controller
        'dropdown'
      end

      # This is defined as a target in the Stimulus controller.
      def toggle_target
        'toggle'
      end
    end
  end
end
