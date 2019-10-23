require 'rails_helper'

describe Search::Likes do
  before               { allow_any_instance_of(Search::Likes).to receive(:dom_id).and_return(42) }

  subject              { Capybara.string html }
  let(:html)           { render_inline(Search::Likes, options) }
  let(:options)        { { q: search_double, builder: builder_double } }
  let(:search_double)  { Ransack::Search.new(Book, params) }
  let(:builder_double) { double('builder').as_null_object }
  let(:params)         { { likes_count_gteq: 5 } }

  describe 'container' do
    it { is_expected.to have_css('#42.dropdown') }
  end

  describe 'dropdown buttons' do
    it { is_expected.to have_css('.dropdown a.other-likes.btn-outline-primary', text: 'At least') }
    it { is_expected.to have_css('.dropdown a.zero-likes.btn-outline.d-none', text: 'Likes') }
    it { is_expected.to have_css('.dropdown a.btn.btn-sm.dropdown-toggle[href="#"][role="button"][data-toggle="dropdown"][aria-expanded="false"][aria-haspopup="true"]', count: 2) }
    it { is_expected.to have_css('.dropdown a[data-offset="0,10"]', count: 2) }
    it { is_expected.to have_css('.dropdown a[data-boundary="42"]', count: 2) }
  end

  describe 'dropdown menu' do
    it { is_expected.to have_css('.dropdown .dropdown-menu.dropdown-menu-right[aria-labelledby="42"]') }

    describe 'content' do
      context '0 likes' do
        it { is_expected.to have_css('.dropdown-menu .zero-likes.d-none') }
      end

      context 'other likes' do
        it { is_expected.to have_css('.dropdown-menu .other-likes').and(have_no_css('.dropdown-menu .other-likes.d-none')) }
      end

      it { is_expected.to have_css('.dropdown .dropdown-menu button.close') }

      it do
        expect(builder_double).to receive(:range_field)
        subject
      end
    end
  end

  describe 'Stimulus' do
    it { is_expected.to have_css('#42[data-controller="dropdown range-slider"]') }

    it { is_expected.to have_css('button.close[data-action="dropdown#close"]') }
    it { is_expected.to have_css('a[data-action="range-slider#reset"]') }

    it do
      expect(builder_double).to receive(:range_field).with(anything, hash_including(data: { target: 'range-slider.range', action: 'input->range-slider#updateValue input->dropdown#updatePosition' }))
      subject
    end
  end
end
