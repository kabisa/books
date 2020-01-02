require 'rails_helper'

describe Search::Filter::Dropdown, type: :component do
  let(:html) { render_inline(Search::Filter::Dropdown, options) { content } }
  subject       { Capybara.string html }

  let(:options) do
    { title: title }
  end
  let(:title) { 'Greetings' }
  let(:content) { 'Hello World!' }

  describe 'container' do
    it { is_expected.to have_css('.dropdown.ml-1') }
  end

  describe 'Stimulus API' do
    it { is_expected.to have_css('.dropdown[data-controller="dropdown"]') }
    it { is_expected.to have_css('.dropdown a[data-target="dropdown.toggle"]') }
    it { is_expected.to have_css('.dropdown-menu[data-action="click->dropdown#keepOpen"]') }
    it { is_expected.to have_css('.close[data-action="dropdown#close"]') }
  end

  describe 'button' do
    it { is_expected.to have_css('.dropdown a[href="#"]', text: title) }
    it { is_expected.to have_css('.dropdown a.btn.btn-sm.dropdown-toggle.btn-outline') }
    it { is_expected.to have_css('.dropdown a[role="button"]') }
    it { is_expected.to have_css('.dropdown a[id]') }
    it { is_expected.to have_css('.dropdown a[data-toggle="dropdown"][data-flip="false"][data-boundary][data-offset="0,10"]') }

    context 'with toggle_options' do
      let(:options) do
        {
          title: title,
          toggle_html: { data: { target: 'dropdown.target' }}
        }
      end

      describe 'Stimulus API' do
        it { is_expected.to have_css('.dropdown a[data-target="dropdown.toggle dropdown.target"]') }
      end
    end
  end

  describe 'dropdown menu' do
    it { is_expected.to have_css('.dropdown .dropdown-menu.dropdown-menu-right[aria-labelledby]') }
    it { is_expected.to have_css('.dropdown-menu button.close[type="button"]', text: '×') }
    it { is_expected.to have_css('.dropdown-menu h4', text: title) }
    it { is_expected.to have_css('.dropdown-menu', text: content) }
  end
end
