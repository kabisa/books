require 'rails_helper'

describe Search::Filter::Likes, type: :component do
  before               { allow_any_instance_of(Search::Filter::Likes).to receive(:dom_id).and_return(42) }

  subject              { Capybara.string html }
  let(:html)           { render_inline(Search::Filter::Likes, options) }
  let(:options)        { { q: search_double, builder: builder_double } }
  let(:search_double)  { Ransack::Search.new(Book, params) }
  let(:builder_double) { double('builder').as_null_object }
  let(:params)         { { likes_count_gteq: likes_count_gteq } }
  let(:likes_count_gteq) { 0 }

  describe 'container' do
    it { is_expected.to have_css('.dropdown') }
  end

  describe 'button' do
    it { is_expected.to have_css('.dropdown a[href="#"]', text: 'Likes') }
    # Other functionality is tested by `spec/components/search/filter/dropdown_spec.rb`
  end

  describe 'dropdown menu' do
    it { is_expected.to have_css('.dropdown-menu .zero-items:not(.d-none)', text: 'Any') }

    it do
      expect(builder_double).to receive(:range_field)
      subject
    end

    context 'initially some likes' do
      let(:likes_count_gteq) { 5 }

      it { is_expected.to have_css('.dropdown-menu .other-items:not(.d-none)', text: 'At least') }
    end
  end

  describe 'Stimulus API' do
    it { is_expected.to have_css('[data-controller="range-slider"]') }

    it { is_expected.to have_css('.dropdown a[data-target="dropdown.toggle range-slider.dropdownToggle"]') }
    it { is_expected.to have_css('.other-items a[href="#"][data-action="range-slider#reset range-slider#updateButton"]', text: 'Clear') }
    it { is_expected.to have_css('.other-items [data-target="range-slider.label"]', text: 'At least') }
    it { is_expected.to have_css('.other-items span[data-target="range-slider.value"]', text: nil) } # Stimulus will set the text.

    it do
      expect(builder_double).to receive(:range_field).with(anything, hash_including(data: { target: 'range-slider.range', action: 'input->range-slider#updateValue input->range-slider#updateButton' }))
      subject
    end
  end
end
