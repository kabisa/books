class Material::ProgressPreview < ActionView::Component::Preview
  layout 'preview'

  attr_accessor :background, :html

  def with_default_background
    render_component
  end

  def with_success_background
    self.background = 'success'
    render_component
  end

  def with_info_background
    self.background = 'info'
    render_component
  end

  def with_warning_background
    self.background = 'warning'
    render_component
  end

  def with_danger_background
    self.background = 'danger'
    render_component
  end

  def with_primary_background
    self.background = 'primary'
    render_component
  end

  def with_secondary_background
    self.background = 'secondary'
    render_component
  end

  def with_html_options
    self.html = { title: 'You can pass HTML attributes to this component', data: { toggle: 'tooltip' }}
    render_component
  end

  private

  def render_component
    render(Material::Progress, options)
  end

  def options
    {
      value: { now: 10, max: 15 },
      background: background,
      html: html
    }
  end

  def html
    @html || {}
  end
end
