class Bootstrap::AlertPreview < ViewComponent::Preview
  include ActionView::Helpers::UrlHelper
  layout 'preview'

  Bootstrap::Alert::ALLOWED_TYPES.each do |type|
    define_method "with_#{type}" do
      self.type = type
      render_component
    end
  end

  private

  attr_accessor :content, :type

  def render_component
    render(Bootstrap::Alert.new(options))
  end

  def options
    {
      content: content,
      type: type
    }
  end

  def content
    @content || Faker::Lorem.sentence
  end
end
