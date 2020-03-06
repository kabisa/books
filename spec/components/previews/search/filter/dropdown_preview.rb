class Search::Filter::DropdownPreview < ViewComponent::Preview
  layout 'preview'

  def default
    render(Search::Filter::Dropdown.new(title: 'Greetings')) { 'Hello World!' }
  end
end
