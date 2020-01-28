class Search::Filter::PublicationPreview < ActionView::Component::Preview
  layout 'preview'

  def with_no_publication_date
    self.published_years_ago_lteq = 0
    self.published_years_ago_gteq = Search::Filter::Publication::PUBLISHED_YEARS_AGO_UPPER
    render_component
  end

  def with_min_publication_date
    self.published_years_ago_lteq = 2
    self.published_years_ago_gteq = Search::Filter::Publication::PUBLISHED_YEARS_AGO_UPPER
    render_component
  end

  def with_max_publication_date
    self.published_years_ago_lteq = 0
    self.published_years_ago_gteq = 8
    render_component
  end

  def with_min_and_max_publication_date
    self.published_years_ago_lteq = 2
    self.published_years_ago_gteq = 8
    render_component
  end

  private

  attr_accessor :published_years_ago_lteq, :published_years_ago_gteq

  def render_component
    render(Search::Form, options).css('[data-controller="publication"]')
  end

  def options
    { q: q }
  end

  def q
    Ransack::Search.new(Book, params)
  end

  def params
    { published_years_ago_lteq: published_years_ago_lteq,
      published_years_ago_gteq: published_years_ago_gteq }
  end
end
