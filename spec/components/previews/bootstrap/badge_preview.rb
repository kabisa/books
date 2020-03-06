class Bootstrap::BadgePreview < ViewComponent::Preview
  include ActionView::Helpers::UrlHelper
  layout 'preview'

  Bootstrap::Badge::ALLOWED_TYPES.each do |type|
    define_method "with_#{type}" do
      self.type = type
      render_component
    end
  end

  private

  attr_accessor :content, :type

  def render_component
    render(Bootstrap::Badge.new(options))
  end

  def options
    {
      content: content,
      type: type
    }
  end

  def content
    @content || Faker::Lorem.word
  end
end
