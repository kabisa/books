class Search::Filter::PagesPreview < ActionView::Component::Preview
  layout 'preview'

  def with_no_pages
    self.num_of_pages_gteq = 0
    self.num_of_pages_lteq = 500
    render_component
  end

  def with_min_pages
    self.num_of_pages_gteq = 100
    self.num_of_pages_lteq = 500
    render_component
  end

  def with_max_pages
    self.num_of_pages_gteq = 0
    self.num_of_pages_lteq = 400
    render_component
  end

  def with_min_and_max_pages
    self.num_of_pages_gteq = 100
    self.num_of_pages_lteq = 400
    render_component
  end

  private

  attr_accessor :num_of_pages_gteq, :num_of_pages_lteq

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
    { num_of_pages_gteq: num_of_pages_gteq,
      num_of_pages_lteq: num_of_pages_lteq }
  end
end
