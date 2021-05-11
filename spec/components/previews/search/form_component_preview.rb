class Search::FormComponentPreview < ViewComponent::Preview
  layout 'preview'

  def with_nothing_checked_and_no_likes
    self.tags_id_in = nil
    self.likes_count_gteq = 0
    render_component
  end

  def with_one_item_checked_and_no_likes
    self.tags_id_in = tag_ids(1)
    self.likes_count_gteq = 0
    render_component
  end

  def with_multiple_items_checked_and_no_likes
    self.tags_id_in = tag_ids(3)
    self.likes_count_gteq = 0
    render_component
  end

  def with_nothing_checked_and_any_likes
    self.tags_id_in = nil
    self.likes_count_gteq = 5
    render_component
  end

  def with_one_item_checked_and_any_likes
    self.tags_id_in = tag_ids(1)
    self.likes_count_gteq = 5
    render_component
  end

  def with_multiple_items_checked_and_any_likes
    self.tags_id_in = tag_ids(3)
    self.likes_count_gteq = 5
    render_component
  end

  private

  attr_accessor :tags_id_in, :likes_count_gteq

  def render_component
    render(Search::FormComponent.new(**options))
  end

  def options
    { q: q }
  end

  def q
    Ransack::Search.new(Book, params)
  end

  def params
    { tags_id_in: tags_id_in, likes_count_gteq: likes_count_gteq }
  end

  def tag_ids(count = 1)
    Book.tags_on(:tags).sort_by { |t| t.name.downcase }.first(count).map(&:id)
  end
end
