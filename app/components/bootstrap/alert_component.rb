module Bootstrap
  class AlertComponent < ViewComponent::Base
    ALLOWED_TYPES = %i[primary secondary danger info success warning dark light].freeze
    DEFAULT_TYPE = ALLOWED_TYPES.last

    def initialize(text:, type: DEFAULT_TYPE)
      @text = text
      self.type = type
    end

    private

    attr_reader :text, :type

    def type=(value)
      @type = (ALLOWED_TYPES.include?(value.to_sym) && value.to_sym) || DEFAULT_TYPE
    end

    def alert_class
      "alert-#{type}"
    end
  end
end
