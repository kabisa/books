class Search::Filter::TagsPreview < ActionView::Component::Preview
  layout 'preview'

  attr_accessor :tags_id_in

  def with_nothing_checked
    self.tags_id_in = nil
    render_component
  end

  def with_one_item_checked
    self.tags_id_in = tag_ids(1)
    render_component
  end

  def with_multiple_items_checked
    self.tags_id_in = tag_ids(3)
    render_component
  end

  private

  def render_component
    render(Search::Form, options).css('[data-controller="checkboxes"]')
  end

  def options
    { q: q }
  end

  def q
    Ransack::Search.new(Book, params)
  end

  def params
    { tags_id_in: tags_id_in }
  end

  def tag_ids(count=1)
    Book.tags_on(:tags).sort_by { |t| t.name.downcase }.first(count).map(&:id)
  end
end
