require 'rails_helper'

RSpec.describe BookDecorator do
  let(:decorator)   { described_class.new(book) }

  describe 'decorates_association' do
    let(:book) { create :ebook, comments_count: 1 }

    it do
      expect(decorator.comments.first).to be_decorated
    end

  end

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

  describe '#formatted_tag_list' do
    subject { Capybara.string decorator.formatted_tag_list }

    let(:book) { build :ebook, tag_list: 'lorem, ipsum' }

    it { is_expected.to have_css('small.text-muted i.material-icons', text: 'label') }
    it { is_expected.to have_css('small.text-muted', text: book.tag_list.to_s) }
  end

  describe '#number_of_comments' do
    subject    { decorator.number_of_comments }
    let(:book) { create :ebook, comments_count: comments_count }

    context 'no comments' do
      let(:comments_count) { 0 }

      it { is_expected.to eql('0 Comments') }
    end

    context 'one comments' do
      let(:comments_count) { 1 }

      it { is_expected.to eql('1 Comment') }
    end

    context 'other comments' do
      let(:comments_count) { 2 }

      it { is_expected.to eql('2 Comments') }
    end
  end

  describe '#number_of_comments_icon' do
    subject    { Capybara.string decorator.number_of_comments_icon }
    let(:book) { create :ebook, comments_count: 5 }

    it { is_expected.to have_css('i.material-icons',text: 'mode_comment') }
    it { is_expected.to have_content('5') }
  end
end
