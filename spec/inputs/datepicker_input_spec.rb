require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe 'form', type: :view do
  before do
    travel_to(Date.parse('2004-12-31')) do
      render partial: 'books/form', locals: { book: book }
    end
  end

  let(:book) { build :book }

  describe 'SimpleForm components' do
    describe 'datepicker' do
      it 'renders a text input' do
        expect(rendered).to have_css('.datepicker.form-group.book_published_on .textfield-box input.form-control.string')
      end

      it 'has a label' do
        expect(rendered).to have_css('label[for="book_published_on"]')
      end
      it 'transforms the max_date to a default formatted string' do
        expect(rendered).to have_css('.book_published_on input[data-max="2005-06-30"]')
      end

      it 'sets some default data attributes' do
        expect(rendered).to have_css('.book_published_on input[data-format="yyyy-mm-dd"]')
        expect(rendered).to have_css('.book_published_on input[data-controller="datepicker"]')
      end

    end
  end
end
