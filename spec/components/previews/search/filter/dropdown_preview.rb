class Search::Filter::DropdownPreview < ActionView::Component::Preview
  layout 'preview'

  def default
    render(Search::Filter::Dropdown, title: 'Greetings') { 'Hello World!' }
  end
end

# To preview this component, visit:
# http://localhost:3000/rails/components/search/filter/dropdown/#{method}
