class Material::SnackbarPreview < ActionView::Component::Preview
  include ActionView::Helpers::UrlHelper
  layout 'preview'

  attr_accessor :notice, :action

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

  def render_component
    render(Material::Snackbar, options)
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
