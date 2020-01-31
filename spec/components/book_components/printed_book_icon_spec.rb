require 'rails_helper'

describe BookComponents::PrintedBookIcon, type: :component do
  subject       { Capybara.string html }
  let(:html)    {  render_inline(described_class, options) }
  let(:options) { { book: book.decorate } }

  describe 'with printed copies' do
    let(:book) { build :book, :printed_book, link: nil }

    it { is_expected.to have_css('i.material-icons[title="Printed book"]', text: 'menu_book') }
  end

  describe 'without printed copies' do
    let(:book) { build :book, :ebook, copies_count: 0 }

    it { is_expected.to have_css('i.material-icons:not([title])', text: '0') }
  end
end
