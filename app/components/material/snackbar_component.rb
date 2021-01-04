module Material
  class SnackbarComponent < ViewComponent::Base
    include BootstrapHelper

    def initialize(flash:, action: nil)
      self.action = action || flash[:action]
      self.flash = flash
    end

    def render?
      message.present?
    end

    private

    attr_reader :flash, :action

    def component_class
      class_names = %w[snackbar]
      class_names << 'snackbar-multi-line' if long_message?
      class_names
    end

    def action=(value)
      @action = value&.html_safe
    end

    def flash=(value)
      value.delete(:action)
      @flash = value
    end

    def message
      flash.map { |_type, msg| msg }.to_sentence
    end

    def long_message?
      message.size > 75
    end
  end
end
