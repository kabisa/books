class Material::SnackbarPreview < ViewComponent::Preview
  include ActionView::Helpers::UrlHelper
  layout 'preview'

  def with_a_short_message
    self.notice = Faker::Lorem.sentence
    render_component
  end

  def with_a_long_message
    self.notice = Faker::Lorem.paragraph(sentence_count: 5)
    render_component
  end

  def with_an_action
    self.action = link_to('Undo', '#')
    render_component
  end

  private

  attr_accessor :notice, :action

  def render_component
    render(Material::Snackbar.new(options))
  end

  def options
    {
      flash: { notice: notice },
      action: action
    }
  end

  def notice
    @notice || Faker::Lorem.sentence
  end
end
