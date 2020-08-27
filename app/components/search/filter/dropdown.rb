module Search
  module Filter
    class Dropdown < ViewComponent::Base
      include BootstrapHelper

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
          data: { target: "#{data_controller}.zeroItems" }
        }

        deep_merge_and_join(options, dropdown_options)
      end

      def split_button_options
        options = {
          class: sm_btn_class('text-primary pr-2 d-none'),
          role: 'button',
          data: {
            target: "#{data_controller}.toggle #{data_controller}.otherItems"
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
          target: "#{data_controller}.otherItems",
          action: "#{data_controller}#reset"
        )
      end

      def decorate_dataset(dataset = {})
        return dataset unless live_search? && dataset.has_key?(:action)

        dataset[:action] << ' search#perform'

        dataset
      end

      def deep_merge_and_join(h1, h2)
        h1.deep_merge!(h2) do |key, this_val, other_val|
          [this_val, other_val].join(' ').strip
        end
      end

      def live_search?
        @live_search
      end
    end
  end
end
