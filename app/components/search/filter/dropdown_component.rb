module Search
  module Filter
    class DropdownComponent < ViewComponent::Base
      include BootstrapHelper
      include LiveSearchable

      def initialize(data_controller: 'dropdown', title:, live_search: false)
        @data_controller = data_controller
        @title = title
        @live_search = live_search
      end

      private

      attr_reader :data_controller, :title

      def dropdown_options
        { data: { toggle: :dropdown, flip: false, display: 'static' } }
      end

      def single_button_options
        options = {
          class: sm_btn_class('dropdown-toggle'),
          role: 'button',
          data: { "#{data_controller}-target": "zeroItems" }
        }

        deep_merge_and_join(options, dropdown_options)
      end

      def split_button_options
        options = {
          class: sm_btn_class('text-primary pr-2 d-none'),
          role: 'button',
          data: {
            "#{data_controller}-target": "toggle otherItems"
          }
        }

        deep_merge_and_join(options, dropdown_options)
      end

      def dropdown_caret_options
        {
          class:
            sm_btn_class(
              'text-primary dropdown-toggle dropdown-toggle-split d-none'
            ),
          role: 'button',
          data: dropdown_caret_dataset
        }
      end

      def dropdown_caret_dataset
        decorate_dataset(
          "#{data_controller}-target": "otherItems",
          action: "#{data_controller}#reset"
        )
      end

      def deep_merge_and_join(h1, h2)
        h1.deep_merge!(h2) do |key, this_val, other_val|
          [this_val, other_val].join(' ').strip
        end
      end

      def data_target
        "#{data_controller}-target"
      end
    end
  end
end
