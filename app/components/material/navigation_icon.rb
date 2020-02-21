module Material
  class NavigationIcon < ActionView::Component::Base
    include BootstrapHelper

    def initialize(action_name:)
      @action_name = action_name
    end

    private

    attr_reader :action_name

  end
end
