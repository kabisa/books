require 'rails_helper'

describe Search::Filter::Dropdown, type: :component do
  subject       { Capybara.string html }

  let(:html)    { render_inline(described_class.new(options)) { content } }
  let(:options) {{ title: title }}
  let(:title)   { 'Greetings' }
  let(:content) { 'Hello World!' }

  describe 'container' do
    it { is_expected.to have_css('.filter-button.dropdown') }
  end

  describe 'buttons' do
    it { is_expected.to have_css('.btn-group.btn-group-fluid.border') }

    describe 'single button' do
      it { is_expected.to have_css('.btn-group a.btn.btn-sm.dropdown-toggle[href="#"][role="button"][data-toggle="dropdown"][data-flip="false"][data-display="static"]', text: title) }
    end

    describe 'split button' do
      it { is_expected.to have_css('.btn-group a.btn.btn-sm.text-primary.pr-2.d-none[href="#"][role="button"][data-toggle="dropdown"][data-flip="false"][data-display="static"]', text: title) }
      it { is_expected.to have_css('.btn-group a.btn.btn-sm.dropdown-toggle.text-primary.dropdown-toggle-split.d-none[href="#"][role="button"]', text: 'Toggle Dropdown') }
    end
    # Other functionality is tested by `spec/components/search/filter/dropdown_spec.rb`
  end

  describe 'dropdown menu' do
    it { is_expected.to have_css('.dropdown .dropdown-menu.dropdown-menu-right') }
    it { is_expected.to have_css('.dropdown-menu button.close[type="button"]', text: '×') }
    it { is_expected.to have_css('.dropdown-menu h4', text: title) }
    it { is_expected.to have_css('.dropdown-menu', text: content) }
  end

  describe 'Stimulus API' do
    it { is_expected.to have_css('.dropdown[data-controller="dropdown"]') }
    it { is_expected.to have_css('.btn-group[data-target="dropdown.button"]') }
    it { is_expected.to have_css('.btn-group .dropdown-toggle[data-target="dropdown.zeroItems"]', text: title) }
    it { is_expected.to have_css('.btn-group [data-target="dropdown.toggle dropdown.otherItems"]') }
    it { is_expected.to have_css('.dropdown-menu[data-action="click->dropdown#keepOpen"]') }
    it { is_expected.to have_css('.dropdown-toggle-split[data-target="dropdown.otherItems"][data-action="dropdown#reset"]') }
    it { is_expected.to have_css('.close[data-action="dropdown#close"]') }
  end
end
