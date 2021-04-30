module Bootstrap
  class AlertComponentPreview < ViewComponent::Preview
    include ActionView::Helpers::UrlHelper
    layout 'preview'

    AlertComponent::ALLOWED_TYPES.each do |type|
      define_method "with_#{type}" do
        self.type = type
        render_component
      end
    end

    private

    attr_accessor :text, :type

    def render_component
      render(AlertComponent.new(options))
    end

    def options
      {
        text: text,
        type: type
      }
    end

    def text
      @text || Faker::Lorem.sentence
    end
  end
end
