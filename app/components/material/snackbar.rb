module Material
  class Snackbar < ActionView::Component::Base
    include BootstrapHelper

    def initialize(flash:, action: nil)
      self.action = action || flash[:action]
      self.flash = flash
    end

    def snackbar_class
      snackbar_class = %w(snackbar)
      snackbar_class << 'snackbar-multi-line' if long_message?
      snackbar_class
    end

    private

    attr_reader :flash, :action

    def action=(value)
      @action = value&.html_safe
    end

    def flash=(value)
      value.delete(:action)
      @flash = value
    end

    def message
      flash.map { |type, msg| msg }.to_sentence
    end

    def long_message?
      message.size > 75
    end
  end
end
