module Search
  class Form < ViewComponent::Base
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
        remote: true,
        html: { autocomplete: :off, data: search_form_dataset }
      }
    end

    def search_form_dataset
      { controller: data_controller, target: "#{data_controller}.form" }
    end

    # Stimulus
    def data_controller
      'search'
    end
  end
end
