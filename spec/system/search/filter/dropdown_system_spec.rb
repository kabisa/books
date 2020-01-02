require 'rails_helper'

# This tests uses the preview located in spec/components/previews...
# and test the JS behaviour managed by Stimulus.
RSpec.describe Search::Filter::Dropdown, type: :system do
  before { visit preview_path.concat('default') }

  let(:preview_path) { '/rails/components/search/filter/dropdown/' }

  it 'has no dropdown' do
    expect(page).not_to have_a_dropdown_menu
  end

  it 'shows a dropdown when button is clicked' do
    open_dropdown
    expect(page).to have_a_dropdown_menu
  end

  it 'closes the dropdown when user clicks outside the dropdown' do
    open_dropdown
    expect(page).to have_a_dropdown_menu
    find('body').click
    expect(page).not_to have_a_dropdown_menu
  end

  it 'keeps the dropdown open when user clicks inside the dropdown' do
    open_dropdown
    expect(page).to have_a_dropdown_menu
    find('h4', text: 'Greetings').click
    expect(page).to have_a_dropdown_menu
  end

  it 'closes the dropdown when the user clicks the close button' do
    open_dropdown
    expect(page).to have_a_dropdown_menu
    find('.dropdown-menu button.close').click
    expect(page).not_to have_a_dropdown_menu
  end

  def open_dropdown
    click_on('Greetings')
  end
end

require 'rspec/expectations'

RSpec::Matchers.define :have_a_dropdown_menu do
  match do |actual|
    expect(actual).to have_css('.dropdown .dropdown-menu')
  end
end
