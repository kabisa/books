class Search::Filter::TagsPreview < ViewComponent::Preview
  layout 'preview'

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

  def with_all_items_checked
    self.tags_id_in = tag_ids
    render_component
  end

  private

  attr_accessor :tags_id_in

  def render_component
    render(Search::Form.new(options))#.css('[data-controller="tags"]')
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

  def tag_ids(count=nil)
    tags = Book.tags_on(:tags).sort_by { |t| t.name.downcase }
    tags = tags.first(count) if count

    tags.map(&:id)
  end
end
