require 'rails_helper'

describe Search::Filter::PublicationComponent, type: :component do
  subject { Capybara.string html }
  let(:html) { render_inline(described_class.new(**options)) }
  let(:options) do
    { q: search_double, builder: builder_double, live_search: live_search }
  end
  let(:search_double) { Ransack::Search.new(Book, params) }
  let(:builder_double) { double('builder').as_null_object }
  let(:live_search) { false }
  let(:params) do
    {
      published_years_ago_lteq: published_years_ago_lteq,
      published_years_ago_gteq: published_years_ago_gteq
    }
  end
  let(:published_years_ago_lteq) { 0 }
  let(:published_years_ago_gteq) { 11 }

  describe 'container' do
    it { is_expected.to have_css('.filter-button.dropdown') }
  end

  describe 'buttons' do
    it { is_expected.to have_css('.btn-group', text: 'Publication') }
    # Other functionality is tested by `spec/components/search/filter/dropdown_spec.rb`
  end

  describe 'dropdown menu' do
    it do
      is_expected.to have_css(
        '.btn-group .dropdown-menu :not(.d-none)',
        text: 'Any'
      )
    end

    it do
      expect(builder_double).to receive(:range_field).twice
      subject
    end
  end

  describe 'Stimulus API' do
    it { is_expected.to have_css('[data-controller="publication"]') }

    it do
      is_expected.to have_css(
        '.btn-group [data-publication-target="zeroItems"]',
        text: 'Publication'
      )
    end
    it do
      is_expected.to have_css(
        '.btn-group [data-publication-target="otherItems"][data-action="publication#reset"]',
        text: 'Toggle Dropdown'
      )
    end
    it do
      is_expected.to have_css(
        '.btn-group [data-publication-target="zeroItems"]',
        text: 'Any'
      )
    end
    it do
      is_expected.to have_css(
        '.btn-group [data-publication-target="otherItems"] [data-publication-target="label"]',
        text: nil
      )
    end
    it do
      is_expected.to have_css(
        '.btn-group [data-action="publication#reset"]',
        text: 'Clear'
      )
    end

    it do
      expect(builder_double).to receive(:range_field).with(
        anything,
        hash_including(
          data: {
            'publication-target': 'min',
            action: 'change->publication#validate input->publication#render'
          }
        )
      )
      subject
    end

    it do
      expect(builder_double).to receive(:range_field).with(
        anything,
        hash_including(
          data: {
            'publication-target': 'max',
            action: 'change->publication#validate input->publication#render'
          }
        )
      )
      subject
    end
  end
end
