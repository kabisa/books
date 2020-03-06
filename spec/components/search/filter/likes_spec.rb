require 'rails_helper'

describe Search::Filter::Likes, type: :component do
  subject              { Capybara.string html }
  let(:html)           { render_inline(described_class.new(options)) }
  let(:options)        { { q: search_double, builder: builder_double } }
  let(:search_double)  { Ransack::Search.new(Book, params) }
  let(:builder_double) { double('builder').as_null_object }
  let(:params)         { { likes_count_gteq: likes_count_gteq } }
  let(:likes_count_gteq) { 0 }

  describe 'container' do
    it { is_expected.to have_css('.filter-button.dropdown') }
  end

  describe 'buttons' do
    it { is_expected.to have_css('.btn-group', text: 'Likes') }
    # Other functionality is tested by `spec/components/search/filter/dropdown_spec.rb`
  end

  describe 'dropdown menu' do
    it { is_expected.to have_css('.btn-group .dropdown-menu :not(.d-none)', text: 'Any') }

    it do
      expect(builder_double).to receive(:range_field)
      subject
    end

    context 'initially some likes' do
      let(:likes_count_gteq) { 5 }

      it { is_expected.to have_css('.dropdown-menu :not(.d-none)', text: 'At least') }
    end
  end

  describe 'Stimulus API' do
    it { is_expected.to have_css('[data-controller="likes"]') }

    it { is_expected.to have_css('.btn-group [data-target="likes.zeroItems"]', text: 'Likes') }
    it { is_expected.to have_css('.btn-group [data-target="likes.otherItems"][data-action="likes#reset"]', text: 'Toggle Dropdown') }
    it { is_expected.to have_css('.btn-group [data-target="likes.zeroItems"]', text: 'Any') }
    it { is_expected.to have_css('.btn-group [data-target="likes.otherItems"]', text: 'At least') }
    it { is_expected.to have_css('.btn-group [data-target="likes.label"]', text: 'At least') }
    it { is_expected.to have_css('.btn-group span[data-target="likes.value"]', text: nil) } # Stimulus will set the text.
    it { is_expected.to have_css('.btn-group [data-action="likes#reset"]', text: 'Clear') }

    it do
      expect(builder_double).to receive(:range_field).with(anything, hash_including(data: { target: 'likes.range', action: 'input->likes#render' }))
      subject
    end
  end
end
