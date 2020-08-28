class Search::Filter::DropdownComponentPreview < ViewComponent::Preview
  layout 'preview'

  def default
    render(Search::Filter::DropdownComponent.new(title: 'Greetings')) do
      'Hello World!'
    end
  end
end
