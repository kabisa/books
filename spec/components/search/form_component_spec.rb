require 'rails_helper'

describe Search::FormComponent, type: :component do
  before do
    allow_any_instance_of(described_class).to receive(:url_for).and_return('#')
  end

  subject { Capybara.string html }
  let(:html) { render_inline(described_class.new(options)) }
  let(:options) { { q: search_double, live_search: live_search } }
  let(:search_double) { Ransack::Search.new(Book, params) }
  let(:params) { {} }

  describe 'with live search' do
    let(:live_search) { true }

    it 'does not render a Search button' do
      is_expected.not_to have_css(
        '.search-form form .action-buttons button',
        text: 'Search'
      )
    end

    it { is_expected.to have_css('form[data-remote="true"]') }

    it 'adds some whitespace' do
      is_expected.not_to have_css('.search-form .form-group.mb-0')
    end

    describe 'Stimulus API' do
      it { is_expected.to have_css('form[data-controller="search"]') }
      it { is_expected.to have_css('form[data-target="search.form"]') }
    end

    [
      Search::Filter::PublicationComponent,
      Search::Filter::PagesComponent,
      Search::Filter::TagsComponent,
      Search::Filter::LikesComponent
    ].each do |component|
      it "passes the boolean to the #{component} component" do
        expect(component).to receive(:new).with(
          hash_including(live_search: true)
        ).and_return(double('ViewComponent').as_null_object)
        subject
      end
    end
  end

  describe 'without live search' do
    let(:live_search) { false }

    it 'renders a Search button' do
      is_expected.to have_css(
        '.search-form form .action-buttons button',
        text: 'Search'
      )
    end

    describe 'Stimulus API' do
      it { is_expected.not_to have_css('form[data-controller="search"]') }
      it { is_expected.not_to have_css('form[data-target="search.form"]') }
    end

    it { is_expected.not_to have_css('form[data-remote="true"]') }

    it 'adds some whitespace' do
      is_expected.to have_css('.search-form .form-group.mb-0')
    end
  end
end
