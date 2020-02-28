module Bootstrap
  class Badge < ActionView::Component::Base
    ALLOWED_TYPES = %i(primary secondary danger info success warning dark light)
    DEFAULT_TYPE=ALLOWED_TYPES.last

    def initialize(content:, type: DEFAULT_TYPE)
      @content = content
      self.type = type
    end

    private

    attr_reader :content, :type

    def type=(value)
      @type = (ALLOWED_TYPES.include?(value.to_sym) && value.to_sym) || DEFAULT_TYPE
    end

    def badge_class
      "badge-#{type}"
    end
  end
end