class Search::Filter::LikesPreview < ActionView::Component::Preview
  include ActionView::Helpers::FormHelper

  layout 'preview'

  attr_accessor :likes_count_gteq, :output_buffer

  def with_no_likes
    self.likes_count_gteq = 0
    render(Search::Filter::Likes, options)
  end

  def with_any_likes
    self.likes_count_gteq = 5
    render(Search::Filter::Likes, options)
  end

  private

  def options
    { q: q, builder: builder }
  end

  def q
    Ransack::Search.new(Book, params)
  end

  def params
    { likes_count_gteq: likes_count_gteq }
  end

  def builder
    form_for(q) do |f|
      return f
    end
  end

  def polymorphic_path(*args); end
end

# To view this component, visit:
# http://localhost:3000/rails/components/search/filter/likes/with_no_likes
# http://localhost:3000/rails/components/search/filter/likes/with_any_likes
