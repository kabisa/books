require 'rails_helper'

describe Search::Filter::LikesComponent, type: :component do
  subject { Capybara.string html }
  let(:html) { render_inline(described_class.new(**options)) }
  let(:options) do
    { q: search_double, builder: builder_double, live_search: live_search }
  end
  let(:search_double) { Ransack::Search.new(Book, params) }
  let(:builder_double) { double('builder').as_null_object }
  let(:live_search) { false }
  let(:params) { { likes_count_gteq: likes_count_gteq } }
  let(:likes_count_gteq) { 0 }

  describe 'container' do
    it { is_expected.to have_css('.filter-button.dropdown') }
  end

  describe 'buttons' do
    it { is_expected.to have_css('.btn-group', text: 'Likes') }
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
      expect(builder_double).to receive(:range_field)
      subject
    end

    context 'initially some likes' do
      let(:likes_count_gteq) { 5 }

      it do
        is_expected.to have_css(
          '.dropdown-menu :not(.d-none)',
          text: 'At least'
        )
      end
    end
  end

  describe 'Stimulus API' do
    it { is_expected.to have_css('[data-controller="likes"]') }

    it do
      is_expected.to have_css(
        '.btn-group [data-likes-target="zeroItems"]',
        text: 'Likes'
      )
    end
    it do
      is_expected.to have_css(
        '.btn-group [data-likes-target="zeroItems"]',
        text: 'Any'
      )
    end
    it do
      is_expected.to have_css(
        '.btn-group [data-likes-target="otherItems"]',
        text: 'At least'
      )
    end
    it do
      is_expected.to have_css(
        '.btn-group [data-likes-target="label"]',
        text: 'At least'
      )
    end
    it do
      is_expected.to have_css(
        '.btn-group span[data-likes-target="value"]',
        text: nil
      )
    end # Stimulus will set the text.

    it do
      is_expected.to have_css(
        '.btn-group [data-action="likes#reset"]',
        text: 'Clear'
      )
    end

    it do
      is_expected.to have_css(
        '.btn-group [data-likes-target="otherItems"][data-action="likes#reset"]',
        text: 'Toggle Dropdown'
      )
    end

    it do
      expect(builder_double).to receive(:range_field).with(
        anything,
        hash_including(
          data: { 'likes-target': 'range', action: 'input->likes#render' }
        )
      )
      subject
    end

    describe 'with live search' do
      let(:live_search) { true }

      it do
        is_expected.to have_css(
          '.btn-group [data-action="likes#reset search#perform"]',
          text: 'Clear'
        )
      end
      it do
        is_expected.to have_css(
          '.btn-group [data-likes-target="otherItems"][data-action="likes#reset search#perform"]',
          text: 'Toggle Dropdown'
        )
      end

      it do
        expect(builder_double).to receive(:range_field).with(
          anything,
          hash_including(
            data: {
              'likes-target': 'range',
              action: 'input->likes#render search#perform'
            }
          )
        )
        subject
      end
    end
  end
end
