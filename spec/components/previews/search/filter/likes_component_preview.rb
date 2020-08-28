class Search::Filter::LikesComponentPreview < ViewComponent::Preview
  layout 'preview'

  def with_no_likes
    self.likes_count_gteq = 0
    render_component
  end

  def with_any_likes
    self.likes_count_gteq = 5
    render_component
  end

  private

  attr_accessor :likes_count_gteq

  def render_component
    render(Search::FormComponent.new(options))
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
