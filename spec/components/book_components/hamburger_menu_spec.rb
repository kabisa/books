require 'rails_helper'

describe BookComponents::HamburgerMenu, type: :component do
  subject       { Capybara.string html }
  let(:html)    {  render_inline(described_class, options) }
  let(:options) { { book: book, user: user } }
  let(:book)    { create(:book) }

  describe 'with a guest user' do
    let(:user) { build(:guest) }

    it { is_expected.to have_content('') }
  end

  describe 'with a Kabisa user' do
    let(:user) { build(:user) }

    it { is_expected.to have_css('.dropdown button[data-toggle="dropdown"]', text: 'more_vert') }
    it { is_expected.to have_css('.dropdown ul.dropdown-menu') }
    it { is_expected.to have_css(".dropdown-menu li a.dropdown-item[href='/books/#{book.id}/edit']", text: 'Edit') }
    it { is_expected.to have_css('.dropdown-menu li.dropdown-divider') }
    it { is_expected.to have_css(".dropdown-menu li a.dropdown-item.text-danger[data-remote='true'][data-method='delete'][href='/books/#{book.id}']", text: 'Delete') }

    describe 'with an ebook' do
      let(:book)    { create(:book, :ebook, copies_count: 0) }

      it { is_expected.to have_css(".dropdown-menu li a.dropdown-item[target='_blank'][href='#{book.link}']", text: 'Download') }
      it { is_expected.not_to have_css('.dropdown-menu li', text: 'Borrow') }
    end

    describe 'with a printed book' do
      let(:book)    { create(:book, :printed_book, link: nil, copies_count: 1) }

      describe 'borrowable on one location' do
        it { is_expected.not_to have_css('.dropdown-menu li', text: 'Download') }
        it { is_expected.to have_css('.dropdown-menu li form[method="post"][action^="/borrowings"][data-remote="true"] input[type="submit"][value="Borrow"]') }
      end

      describe 'borrowable on multiple locations' do
        let(:book)    { create(:book, :printed_book, link: nil, copies_count: 2) }

        it { is_expected.not_to have_css('.dropdown-menu li', text: 'Download') }
        it { is_expected.to have_css('.dropdown-menu li.dropdown-submenu') }
        it { is_expected.to have_css('.dropdown-submenu .dropdown-item', text: 'Borrow') }
        it { is_expected.to have_css('.dropdown-submenu ul.dropdown-menu li form[method="post"][action^="/borrowings"][data-remote="true"]', count: 2) }
      end

      describe 'borrowed by the user' do
        before do
          book.copies.first.borrowings.create(user: user)
        end

        it { is_expected.not_to have_css('.dropdown-menu li', text: 'Download') }
        it { is_expected.to have_css('.dropdown-menu li form input[name="_method"][value="delete"]', visible: false) }
        it { is_expected.to have_css('.dropdown-menu li form input.dropdown-item[value="Return book"]') }
      end

      describe 'borrowed by another user' do
        before do
          copy = book.copies.first

          copy.number.times do
            copy.borrowings.create(user: create(:user))
          end
        end

        it { is_expected.not_to have_css('.dropdown-menu li', text: 'Download') }
        it { is_expected.to have_css('.dropdown-menu li.dropdown-item.disabled', text: 'Borrow') }
      end
    end
  end
end
