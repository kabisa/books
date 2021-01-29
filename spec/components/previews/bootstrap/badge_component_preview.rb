module Bootstrap
  class BadgeComponentPreview < ViewComponent::Preview
    include ActionView::Helpers::UrlHelper
    layout 'preview'

    BadgeComponent::ALLOWED_TYPES.each do |type|
      define_method "with_#{type}" do
        self.type = type
        render_component
      end
    end

    private

    attr_accessor :content, :type

    def render_component
      render(BadgeComponent.new(options))
    end

    def options
      {
        text: text,
        type: type
      }
    end

    def text
      @text || Faker::Lorem.word
    end
  end
end
