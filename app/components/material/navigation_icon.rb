module Material
  class NavigationIcon < ActionView::Component::Base
    include BootstrapHelper

    def initialize(action_name:)
      @action_name = action_name
    end

    private

    attr_reader :action_name

    def menu?
      action_name == 'index'
    end

    def url
      case action_name
      when 'update', 'create'
        root_path
      else
        go_back
      end
    end

    def go_back
      'javascript:history.back()'
    end

    def toggler_class
      'navbar-toggler'
    end
  end
end
