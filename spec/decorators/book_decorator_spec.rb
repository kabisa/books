require 'rails_helper'

RSpec.describe BookDecorator do
  let(:decorator) { described_class.new(book) }

  describe 'decorates_association' do
    let(:book) { create :book, comments_count: 1 }

    it { expect(decorator.comments.first).to be_decorated }
  end

  describe '#dom_id' do
    subject    { decorator.dom_id(:lorem) }
    let(:book) { build :book }

    it { is_expected.to eql('lorem_book') }
  end

  describe '#available_copies' do
    before do
      allow(book).to receive(:copies_count).and_return(5)
      allow(book).to receive(:borrowings_count).and_return(3)
    end

    subject { decorator.available_copies }

    let(:book) { create :book, :printed_book }

    it { is_expected.to eql(2) }
  end

  describe '#formatted_available_copies' do
    before do
      allow(book).to receive(:copies_count).and_return(5)
      allow(book).to receive(:borrowings_count).and_return(3)
    end

    subject { decorator.formatted_available_copies }

    let(:book) { create :book, :printed_book }

    it { is_expected.to eql('2 copies') }
  end

  describe '#media_and_pages' do
    subject { decorator.media_and_pages }

    describe 'with pages' do
      let(:num_of_pages) { 10 }

      describe 'with link' do
        let(:book) { build :book, :ebook, num_of_pages: num_of_pages }

        it { is_expected.to eql('E-book, 10 pages') }
      end

      describe 'with printed copies' do
        let(:book) { build :book, :printed_book, link: nil, num_of_pages: num_of_pages }

        it { is_expected.to eql('Printed book, 10 pages') }
      end

      describe 'with link and printed copies' do
        let(:book) { build :book, :printed_book, :ebook, num_of_pages: num_of_pages }

        it { is_expected.to eql('Printed book, E-book, 10 pages') }
      end
    end

    describe 'without pages' do
      let(:num_of_pages) { nil }

      describe 'with link' do
        let(:book) { build :book, :ebook, num_of_pages: num_of_pages }

        it { is_expected.to eql('E-book') }
      end

      describe 'with printed copies' do
        let(:book) { build :book, :printed_book, link: nil, num_of_pages: num_of_pages }

        it { is_expected.to eql('Printed book') }
      end

      describe 'with link and printed copies' do
        let(:book) { build :book, :printed_book, :ebook, num_of_pages: num_of_pages }

        it { is_expected.to eql('Printed book, E-book') }
      end
    end
  end

  describe '#book_type_icon' do
    before do
      allow(h).to receive(:current_user).and_return(user)
    end

    subject { Capybara.string html }

    let(:html) { decorator.book_type_icon }

    describe 'with a guest user' do
      let(:user) { build(:guest) }
      let(:book) { build :book, :printed_book, :ebook }

      it { is_expected.not_to have_css('i') }
    end

    describe 'with a Kabisa user' do
      let(:user)    { build(:user) }

      describe 'with link' do
        let(:book) { build :book, :ebook }

        it { is_expected.to have_css('i.material-icons', text: '0') }
        it { is_expected.to have_css('i.material-icons', text: 'tablet_android') }

        it { is_expected.to have_css('i.material-icons:not([title]) + i.material-icons[title]') }
      end

      describe 'with printed copies' do
        let(:book) { build :book, :printed_book, link: nil }

        it { is_expected.to have_css('i.material-icons', text: 'menu_book') }
        it { is_expected.to have_css('i.material-icons', text: '0') }
        it { is_expected.to have_css('i.material-icons[title] + i.material-icons:not([title])') }
      end

      describe 'with link and printed copies' do
        let(:book) { build :book, :printed_book, :ebook }

        it { is_expected.to have_css('i.material-icons', text: 'menu_book') }
        it { is_expected.to have_css('i.material-icons', text: 'tablet_android') }
      end
    end
  end

  describe '#printed_book_icon' do
    before do
      allow(h).to receive(:current_user).and_return(user)
    end

    subject { Capybara.string html }

    let(:html) { decorator.printed_book_icon }
    let(:book) { build :book }
    let(:user) { build :user }
    let(:options) do
      {
        book: book,
        user: user
      }
    end

    it 'delegates to the BookComponents::PrintedBookIcon component' do
      expect(h).to receive(:render).with(BookComponents::PrintedBookIcon, options)
      subject
    end
  end

  describe '#formatted_published_on' do
    subject    { decorator.formatted_published_on }
    let(:book) { build :book, published_on: published_on }

    describe 'published_on' do
      let(:published_on) { Date.parse('2004-12-31') }

      it { is_expected.to eql('Published 2004-12-31') }
    end

    describe 'without published_on' do
      let(:published_on) { nil }

      it { is_expected.to be_nil }
    end
  end

  describe '#title_highlighted_with_search' do
    before            { allow(h).to receive(:params).and_return(params_stub) }

    subject           { decorator.title_highlighted_with_search }
    let(:book)        { build :book, title: 'Lorem Ipsum' }
    let(:params_stub) { ActionController::Parameters.new(parameters) }

    context 'with search param' do
      let(:parameters) { { q: { title_or_summary_or_writers_name_cont: 'lorem' } } }

      it { is_expected.to eql('<mark>Lorem</mark> Ipsum') }
    end

    context 'without search param' do
      let(:parameters) { { lorem: 'ipsum' } }

      it { is_expected.to eql('Lorem Ipsum') }
    end
  end

  describe '#summary_highlighted_with_search' do
    before            { allow(h).to receive(:params).and_return(params_stub) }

    subject           { decorator.summary_highlighted_with_search.delete("\n") }
    let(:book)        { build :book, summary: "Lorem\nIpsum" }
    let(:params_stub) { ActionController::Parameters.new(parameters) }

    context 'with search param' do
      let(:parameters) { { q: { title_or_summary_or_writers_name_cont: 'lorem' } } }

      it { is_expected.to eql('<p><mark>Lorem</mark><br>Ipsum</p>') }
    end

    context 'without search param' do
      let(:parameters) { { lorem: 'ipsum' } }

      it { is_expected.to eql('<p>Lorem<br>Ipsum</p>') }
    end
  end

  describe '#formatted_tag_list' do
    subject { Capybara.string decorator.formatted_tag_list }

    let(:book) { build :book, tag_list: 'lorem, ipsum' }

    it { is_expected.to have_css('small.text-muted i.material-icons', text: 'label') }
    it { is_expected.to have_css('small.text-muted', text: book.tag_list.to_s) }
  end

  describe '#number_of_comments' do
    subject    { decorator.number_of_comments }
    let(:book) { create :book, comments_count: comments_count }

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
    let(:book) { create :book, comments_count: 5 }

    it { is_expected.to have_css('i.material-icons',text: 'mode_comment') }
    it { is_expected.to have_content('5') }
  end

  describe '#truncated_summary' do
    subject    { decorator.truncated_summary }
    let(:book) { create :book, summary: summary }
    let(:summary) do
      <<~SUMMARY
        Bla
        #{"Bla " * 50}
        #{"Bla " * 100}
        #{"Bla " * 150}
        Bla
      SUMMARY
    end

    it { expect(subject.size).to eql(240) }
    it { is_expected.to have_content('...') }
  end

  describe '#truncated_summary_html' do
    subject    { Capybara.string decorator.truncated_summary_html }
    let(:book) { create :book, summary: summary }
    let(:summary) do
      <<~SUMMARY
        Bla
        #{"Bla " * 50}
        #{"Bla " * 100}
        #{"Bla " * 150}
        Bla
      SUMMARY
    end

    it { expect(subject.text.size).to eql(240) }
    it { is_expected.to have_css('p') }
    it { is_expected.to have_css('br', count: 2) }
    it { is_expected.to have_content('...') }

    describe 'with options passed' do
      subject       { Capybara.string decorator.truncated_summary_html(options) }
      let(:options) { { class: 'lorem' } }

      it { is_expected.to have_css('p.lorem') }

    end
  end

  describe '#written_by' do
    subject       { decorator.written_by }
    let(:book)    { create :book, writers: [stephen, charles] }
    let(:stephen) { create :writer, name: 'Stephen King' }
    let(:charles) { create :writer, name: 'Charles Dickens' }

    it { is_expected.to eql('By Stephen King and Charles Dickens') }

    context 'no writers' do
      let(:book) { create :book }

      it { is_expected.to be_nil }
    end
  end

  describe '#written_by_highlighted_with_search' do
    before do
      allow(h).to receive(:params).and_return(params_stub)
    end

    subject { decorator.written_by_highlighted_with_search }

    let(:book)        { create :book, writers: [stephen, charles] }
    let(:stephen)     { create :writer, name: 'Stephen King' }
    let(:charles)     { create :writer, name: 'Charles Dickens' }
    let(:params_stub) { ActionController::Parameters.new(parameters) }

    context 'with search param' do
      subject          { Capybara.string decorator.written_by_highlighted_with_search }
      let(:parameters) { { q: { title_or_summary_or_writers_name_cont: 'king' } } }

      it { is_expected.to have_css('a[href$="q%5Bwriters_name_eq%5D=Stephen+King"] mark' ,text: 'King') }
    end

    context 'no writers' do
      let(:book)       { create :book }
      let(:parameters) { { q: { title_or_summary_or_writers_name_cont: 'king' } } }

      it { is_expected.to be_nil }
    end
  end

  describe '#currently_borrowing_alert' do
    before     { allow(h).to receive(:current_user).and_return(user) }

    let(:html) { decorator.currently_borrowing_alert }
    let(:book) { create :book, :printed_book }
    let(:user) { create :user }

    context 'user is borrowing' do
      before  { Borrowing.create(user: user, copy: book.copies.first) }

      subject { Capybara.string html }

      it      { is_expected.to have_css('.alert.alert-info', text: 'You are currently borrowing a copy.') }
    end

    context 'user is not borrowing' do
      subject { html }

      it      { is_expected.to be_nil }
    end
  end
end
