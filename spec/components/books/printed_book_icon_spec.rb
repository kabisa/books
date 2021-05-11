require 'rails_helper'

module Books
  describe PrintedBookIconComponent, type: :component do
    subject       { Capybara.string html }
    let(:html)    { render_inline(described_class.new(**options)) }
    let(:options) { { book: book.decorate, user: user } }
    let(:user)    { build(:user) }

    describe 'with a printed book' do
      let(:book) { create(:book, :printed_book, link: nil, copies_count: 1) }

      describe 'with available copies' do
        it { is_expected.to have_css('i.material-icons:not(.text-muted)[title="Printed book"]', text: 'menu_book') }
      end

      describe 'without avaiable copies' do
        before do
          copy = book.copies.first

          copy.number.times do
            copy.borrowings.create(user: create(:user))
          end
        end

        it {
          is_expected.to have_css('i.material-icons.text-muted[title="Printed book, no copies available"]',
                                  text: 'menu_book')
        }
      end

      describe 'borrowed by the user' do
        before do
          book.copies.first.borrowings.create(user: user)
        end

        it {
          is_expected.to have_css('i.material-icons.text-primary[title="Printed book, you are currently borrowing a copy."]',
                                  text: 'menu_book')
        }
      end
    end

    describe 'with an ebook' do
      let(:book) { create(:book, :ebook, copies_count: 0) }

      it { is_expected.to have_css('i.material-icons:not([title])', text: '0') }
    end
  end
end
