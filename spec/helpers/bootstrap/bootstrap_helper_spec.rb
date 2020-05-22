require 'rails_helper'

RSpec.describe BootstrapHelper, type: :helper do
  describe '#responsive_card_deck' do
    subject { helper.responsive_card_deck(idx) }

    describe 'with idx 0' do
      let(:idx) { 0 }
      it { is_expected.to be_empty }
    end

    describe 'with idx 1' do
      let(:idx) { 1 }
      it { is_expected.to have_css('div', count: 1) }
      it { is_expected.to have_css('.w-100.d-none.d-sm-block.d-md-none') }
    end

    describe 'with idx 2' do
      let(:idx) { 2 }
      it { is_expected.to have_css('div', count: 1) }
      it { is_expected.to have_css('.w-100.d-none.d-md-block.d-lg-none') }
    end

    describe 'with idx 3' do
      let(:idx) { 3 }
      it { is_expected.to have_css('div', count: 2) }
      it { is_expected.to have_css('.w-100.d-none.d-sm-block.d-md-none') }
      it { is_expected.to have_css('.w-100.d-none.d-lg-block.d-xl-none') }
    end

    describe 'with idx 4' do
      let(:idx) { 4 }
      it { is_expected.to have_css('div', count: 1) }
      it { is_expected.to have_css('.w-100.d-none.d-xl-block') }
    end

    describe 'with idx 5' do
      let(:idx) { 5 }
      it { is_expected.to have_css('div', count: 2) }
      it { is_expected.to have_css('.w-100.d-none.d-sm-block.d-md-none') }
      it { is_expected.to have_css('.w-100.d-none.d-md-block.d-lg-none') }
    end

    describe 'with idx 6' do
      let(:idx) { 6 }
      it { is_expected.to be_empty }
    end
  end
end
