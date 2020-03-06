require 'rails_helper'

describe Search::Filter::Publication, type: :component do
  subject              { Capybara.string html }
  let(:html)           { render_inline(described_class.new(options)) }
  let(:options)        { { q: search_double, builder: builder_double } }
  let(:search_double)  { Ransack::Search.new(Book, params) }
  let(:builder_double) { double('builder').as_null_object }
  let(:params)         do
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
    it { is_expected.to have_css('.btn-group .dropdown-menu :not(.d-none)', text: 'Any') }

    it do
      expect(builder_double).to receive(:range_field).twice
      subject
    end
  end

  describe 'Stimulus API' do
    it { is_expected.to have_css('[data-controller="publication"]') }

    it { is_expected.to have_css('.btn-group [data-target="publication.zeroItems"]', text: 'Publication') }
    it { is_expected.to have_css('.btn-group [data-target="publication.otherItems"][data-action="publication#reset"]', text: 'Toggle Dropdown') }
    it { is_expected.to have_css('.btn-group [data-target="publication.zeroItems"]', text: 'Any') }
    it { is_expected.to have_css('.btn-group [data-target="publication.otherItems"] [data-target="publication.label"]', text: nil) }
    it { is_expected.to have_css('.btn-group [data-action="publication#reset"]', text: 'Clear') }

    it do
      expect(builder_double).to receive(:range_field).with(anything, hash_including(data: { target: 'publication.min', action: 'change->publication#validate input->publication#render' }))
      subject
    end

    it do
      expect(builder_double).to receive(:range_field).with(anything, hash_including(data: { target: 'publication.max', action: 'change->publication#validate input->publication#render' }))
      subject
    end
  end
end
