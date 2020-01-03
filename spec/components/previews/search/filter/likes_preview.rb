class Search::Filter::LikesPreview < ActionView::Component::Preview
  layout 'preview'

  attr_accessor :likes_count_gteq

  def with_no_likes
    self.likes_count_gteq = 0
    render_component
  end

  def with_any_likes
    self.likes_count_gteq = 5
    render_component
  end

  private

  def render_component
    render(Search::Form, options).css('[data-controller="range-slider"]')
  end

  def options
    { q: q }
  end

  def q
    Ransack::Search.new(Book, params)
  end

  def params
    { likes_count_gteq: likes_count_gteq }
  end
end

# To view this component, visit:
# http://localhost:3000/rails/components/search/filter/likes/with_no_likes
# http://localhost:3000/rails/components/search/filter/likes/with_any_likes
