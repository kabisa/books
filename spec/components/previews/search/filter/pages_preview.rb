class Search::Filter::PagesPreview < ActionView::Component::Preview
  layout 'preview'

  def with_no_pages
    self.num_of_pages_gteq = 0
    render_component
  end

  def with_any_pages
    self.num_of_pages_gteq = 100
    render_component
  end

  private

  attr_accessor :num_of_pages_gteq

  def render_component
    render(Search::Form, options).css('[data-controller="pages"]')
  end

  def options
    { q: q }
  end

  def q
    Ransack::Search.new(Book, params)
  end

  def params
    { num_of_pages_gteq: num_of_pages_gteq }
  end
end
