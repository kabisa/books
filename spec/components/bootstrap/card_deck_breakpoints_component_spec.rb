require 'rails_helper'

describe Bootstrap::CardDeckBreakpointsComponent, type: :component do
  subject { Capybara.string html }
  let(:html) { render_inline(described_class.new(options)) }
  let(:options) { { tag_counter: tag_counter } }

  describe 'with 1 tag' do
    subject { html.to_s }
    let(:tag_counter) { 1 }
    it { is_expected.to be_empty }
  end

  describe 'with 2 tags' do
    let(:tag_counter) { 2 }
    it { is_expected.to have_css('div', count: 1) }
    it { is_expected.to have_css('.w-100.d-none.d-sm-block.d-md-none') }
  end

  describe 'with 3 tags' do
    let(:tag_counter) { 3 }
    it { is_expected.to have_css('div', count: 1) }
    it { is_expected.to have_css('.w-100.d-none.d-md-block.d-lg-none') }
  end

  describe 'with 4 tags' do
    let(:tag_counter) { 4 }
    it { is_expected.to have_css('div', count: 2) }
    it { is_expected.to have_css('.w-100.d-none.d-sm-block.d-md-none') }
    it { is_expected.to have_css('.w-100.d-none.d-lg-block.d-xl-none') }
  end

  describe 'with 5 tags' do
    let(:tag_counter) { 5 }
    it { is_expected.to have_css('div', count: 1) }
    it { is_expected.to have_css('.w-100.d-none.d-xl-block') }
  end

  describe 'with 6 tags' do
    let(:tag_counter) { 6 }
    it { is_expected.to have_css('div', count: 2) }
    it { is_expected.to have_css('.w-100.d-none.d-sm-block.d-md-none') }
    it { is_expected.to have_css('.w-100.d-none.d-md-block.d-lg-none') }
  end

  describe 'with 7 tags' do
    subject { html.to_s }
    let(:tag_counter) { 7 }
    it { is_expected.to be_empty }
  end
end
