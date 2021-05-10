require 'rails_helper'

module Books
  describe HamburgerMenuComponent, type: :component do
    subject { Capybara.string html }
    let(:html) { render_inline(described_class.new(options)) }
    let(:options) { { book: book, user: user, show: show } }
    let(:book) { create(:book) }
    let(:show) { true }

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
      it {
        is_expected.to have_css(
          ".dropdown-menu li form[action='/books/#{book.id}'] input[name='_method'][value='delete']", visible: false
        )
        is_expected.to have_css(
          ".dropdown-menu li form[action='/books/#{book.id}'] input.dropdown-item.text-danger[value='Delete']"
        )
      }

      xcontext 'with synchronous calls' do
        let(:remote) { false }
        it { is_expected.to have_no_css(".dropdown-item[data-remote='true']", text: 'Delete') }
      end

      xcontext 'with asynchronous calls' do
        let(:remote) { true }
        it { is_expected.to have_css(".dropdown-item[data-remote='true']", text: 'Delete') }
      end

      describe 'with an ebook' do
        let(:book) { create(:book, :ebook, copies_count: 0) }

        it {
          is_expected.to have_css(".dropdown-menu li a.dropdown-item[target='_blank'][href='#{book.link}']",
                                  text: 'Download')
        }
        it { is_expected.not_to have_css('.dropdown-menu li', text: 'Borrow') }
      end

      describe 'with a printed book' do
        let(:book) { create(:book, :printed_book, link: nil, copies_count: 1) }

        describe 'borrowable on one location' do
          it { is_expected.not_to have_css('.dropdown-menu li', text: 'Download') }
          it {
            is_expected.to have_css('.dropdown-menu li form[method="post"][action^="/borrowings"] input[type="submit"][value="Borrow"]')
          }

          context 'with `show` set to `true`' do
            let(:show) { true }
            it { is_expected.to have_css('form[action*="show=true"] input[type="submit"][value="Borrow"]') }
          end

          context 'with `show` set to `false`' do
            let(:show) { false }
            it { is_expected.to have_css('form[action*="show=false"] input[type="submit"][value="Borrow"]') }
          end
        end

        describe 'borrowable on multiple locations' do
          let(:book) { create(:book, :printed_book, link: nil, copies_count: 2) }

          it { is_expected.not_to have_css('.dropdown-menu li', text: 'Download') }
          it { is_expected.to have_css('.dropdown-menu li.dropdown-submenu') }
          it { is_expected.to have_css('.dropdown-submenu .dropdown-item', text: 'Borrow') }
          it {
            is_expected.to have_css(
              '.dropdown-submenu ul.dropdown-menu li form[method="post"][action^="/borrowings"]', count: 2
            )
          }

          context 'with `show` set to `true`' do
            let(:show) { true }
            it { is_expected.to have_css('.dropdown-submenu ul.dropdown-menu li form[action*="show=true"]') }
          end

          context 'with `show` set to `true`' do
            let(:show) { false }
            it { is_expected.to have_css('.dropdown-submenu ul.dropdown-menu li form[action*="show=false"]', count: 2) }
          end
        end

        describe 'borrowed by the user' do
          before do
            book.copies.first.borrowings.create(user: user)
          end

          it { is_expected.not_to have_css('.dropdown-menu li', text: 'Download') }
          it { is_expected.to have_css('.dropdown-menu li form input[name="_method"][value="delete"]', visible: false) }
          it { is_expected.to have_css('.dropdown-menu li form input.dropdown-item[value="Return book"]') }

          context 'with `show` set to `true`' do
            let(:show) { true }
            it { is_expected.to have_css('.dropdown-menu li form[action*="show=true"]') }
          end

          context 'with `show` set to `true`' do
            let(:show) { false }
            it { is_expected.to have_css('.dropdown-menu li form[action*="show=false"]') }
          end
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
end
