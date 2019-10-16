require 'rails_helper'

RSpec.describe BookDecorator do
  let(:decorator)   { described_class.new(book) }

  describe '#formatted_type' do
    subject { decorator.formatted_type }

    describe 'e-book' do
      let(:book) { build :ebook }

      it { is_expected.to eql('E-book') }
    end

    describe 'printed book' do
      let(:book) { build :printed_book }

      it { is_expected.to eql('Printed book') }
    end
  end

  describe '#dom_id' do
    subject { decorator.dom_id(:lorem) }
    let(:book) { build :ebook }

    it { is_expected.to eql('lorem_ebook') }
  end

  describe '#title_highlighted_with_search' do
    before { allow(h).to receive(:params).and_return(params_stub) }

    subject           { decorator.title_highlighted_with_search }
    let(:book)        { build :ebook, title: 'Lorem Ipsum' }
    let(:params_stub) { ActionController::Parameters.new(parameters) }

    context 'with search param' do
      let(:parameters) { { q: { title_or_summary_cont: "lorem" } } }

      it { is_expected.to eql('<mark>Lorem</mark> Ipsum') }
    end

    context 'without search param' do
      let(:parameters) { { lorem: 'ipsum' } }

      it { is_expected.to eql('Lorem Ipsum') }
    end
  end

  describe '#summary_highlighted_with_search' do
    before { allow(h).to receive(:params).and_return(params_stub) }

    subject           { decorator.summary_highlighted_with_search.delete("\n") }
    let(:book)        { build :ebook, summary: "Lorem\nIpsum" }
    let(:params_stub) { ActionController::Parameters.new(parameters) }

    context 'with search param' do
      let(:parameters) { { q: { title_or_summary_cont: "lorem" } } }

      it { is_expected.to eql('<p><mark>Lorem</mark><br>Ipsum</p>') }
    end

    context 'without search param' do
      let(:parameters) { { lorem: 'ipsum' } }

      it { is_expected.to eql('<p>Lorem<br>Ipsum</p>') }
    end
  end
end
