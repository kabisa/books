class Search::Filter::DropdownPreview < ActionView::Component::Preview
  layout 'preview'

  def default
    render(Search::Filter::Dropdown, title: 'Greetings') { 'Hello World!' }
  end
end
