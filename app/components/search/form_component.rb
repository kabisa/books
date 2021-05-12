module Search
  class FormComponent < ViewComponent::Base
    include Ransack::Helpers::FormHelper
    include BootstrapHelper
    include LiveSearchable

    def initialize(q:, live_search: false)
      @q = q
      @live_search = live_search
    end

    private

    attr_reader :q

    def search_form_options
      return {} unless live_search?

      {
        url: url_for,
        html: { autocomplete: :off, data: search_form_dataset }
      }
    end

    def search_form_dataset
      { controller: data_controller, "#{data_target}": 'form', turbo_frame: 'results' }
    end

    def sort_params(f)
      helpers.safe_join(
        q.sorts.map do |sort|
          f.hidden_field :s, multiple: true, value: "#{sort.name} #{sort.dir}"
        end
      )
    end

    # Stimulus
    def data_controller
      'search'
    end

    def data_target
      "#{data_controller}-target"
    end
  end
end
