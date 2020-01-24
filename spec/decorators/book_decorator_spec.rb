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

    it { is_expected.to eql('2 copies') }
  end

  xdescribe '#book_type_icon' do
    subject { Capybara.string decorator.book_type_icon }

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

  describe '#media_and_pages' do
    let(:html) { decorator.book_type_icon }
    subject { Capybara.string html }

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

  describe '#link_to_edit' do
    let(:html) { decorator.link_to_edit }
    let(:book) { create :book }

    before { allow(h).to receive(:policy).and_return(policy_stub) }

    describe 'authorized user' do
      subject           { Capybara.string html }
      let(:policy_stub) { double('BookPolicy', edit?: true) }

      it { is_expected.to have_css('a.dropdown-item[href$="edit"]', text: 'Edit') }
    end

    describe 'unauthorized user' do
      subject           { html }
      let(:policy_stub) { double('BookPolicy', edit?: false) }

      it { is_expected.to be_nil }
    end
  end

  describe '#link_to_download' do
    let(:html) { decorator.link_to_download }
    let(:book) { create :book, :ebook }

    before { allow(h).to receive(:policy).and_return(policy_stub) }

    describe 'authorized user' do
      subject           { Capybara.string html }
      let(:policy_stub) { double('BookPolicy', download?: true) }

      it { is_expected.to have_css("a[target='_blank'][href='#{book.link}']", text: 'Download') }
    end

    describe 'unauthorized user' do
      subject           { html }
      let(:policy_stub) { double('BookPolicy', download?: false) }

      it { is_expected.to be_nil }
    end
  end

  describe '#link_to_destroy' do
    let(:html) { decorator.link_to_destroy }
    let(:book) { create :book }

    before { allow(h).to receive(:policy).and_return(policy_stub) }

    describe 'authorized user' do
      subject           { Capybara.string html }
      let(:policy_stub) { double('BookPolicy', destroy?: true) }

      it { is_expected.to have_css('.dropdown-divider') }
      it { is_expected.to have_css('a.dropdown-item.text-danger[data-remote="true"][data-method="delete"]', text: 'Delete') }
    end

    describe 'unauthorized user' do
      subject           { html }
      let(:policy_stub) { double('BookPolicy', destroy?: false) }

      it { is_expected.to be_nil }
    end
  end

  describe '#link_to_borrow' do
    before do
      allow(h).to receive(:policy).and_return(policy_stub)
      allow(decorator).to receive(:'borrowed_by?').and_return(false)
    end

    let(:book) { create :book }
    let(:html) { decorator.link_to_borrow }

    describe 'authorized user' do
      subject           { Capybara.string html }
      let(:policy_stub) { double('BookPolicy', borrow?: true) }

      context 'user is borrowing a copy' do
        before do
          allow(decorator).to receive(:'borrowed_by?').and_return(true)
          allow(decorator).to receive(:copies).and_return(double('copies', borrowables: [1]))
          allow(decorator).to receive(:borrow_by).and_return(borrowing)
        end

        let(:borrowing) { build_stubbed(:borrowing) }

        it { is_expected.to have_css('form[method="post"][action^="/borrowings"][data-remote="true"]') }
        it { is_expected.to have_css('form input[name="_method"][value="delete"]', visible: false) }
        it { is_expected.to have_css('form input.dropdown-item[value="Return book"]') }
      end

      context 'copy is not borrowable' do
        before { allow(decorator).to receive(:copies).and_return(double('copies', borrowables: [])) }

        it { is_expected.to have_css('button.dropdown-item[disabled="disabled"]', text: 'Borrow') }
      end

      context 'copy is available on one location' do
        before { allow(decorator).to receive(:copies).and_return(double('copies', borrowables: [1])) }

        it { is_expected.to have_css('form[method="post"][action^="/borrowings"][data-remote="true"]') }
        it { is_expected.to have_css('form input.dropdown-item[value="Borrow"]') }
      end

      context 'copy is available on multiple locations' do
        before do
          allow(decorator).to receive(:copies).and_return(double('copies', borrowables: borrowables))
          allow(h).to receive(:dom_id).and_return(dom_id)
        end

        let(:borrowables) { build_stubbed_list(:copy, 2) }
        let(:dom_id)      { 'dom-id' }

        it { is_expected.to have_css('form input.dropdown-item[value="Borrow..."]') }
      end
    end

    describe 'unauthorized user' do
      subject           { html }
      let(:policy_stub) { double('BookPolicy', borrow?: false) }

      it { is_expected.to be_nil }
    end
  end
end
