module Material
  class Snackbar < ActionView::Component::Base
    def initialize(flash:, action: nil)
      @flash = flash
      @action = action
    end

    private

    attr_reader :flash, :action

    def message
      flash.map { |type, msg| msg }.to_sentence
    end
  end
end
