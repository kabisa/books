module Material
  class Snackbar < ActionView::Component::Base
    def initialize(flash:, action: nil)
      @flash = flash
      @action = action
    end

    def snackbar_class
      snackbar_class = %w(snackbar)
      snackbar_class << 'snackbar-multi-line' if long_message?
      snackbar_class
    end

    private

    attr_reader :flash, :action

    def message
      flash.map { |type, msg| msg }.to_sentence
    end

    def long_message?
      message.size > 75
    end
  end
end
