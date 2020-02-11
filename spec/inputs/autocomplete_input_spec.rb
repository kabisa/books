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
    describe 'autocomplete' do
      describe 'container' do
        it 'renders a container' do
          expect(rendered).to have_css('.form-group.autocomplete.book_reedition_title')
        end
      end

      it 'renders the text input for title' do
        expect(rendered).to have_css('.book_reedition_title input[name="book[reedition_title]"]')
      end

      it 'renders a hidden field for id' do
        expect(rendered).to have_css('.book_reedition_title input[type="hidden"][name="book[reedition_id]"]', visible: false)
      end

      it 'renders a UL for the displaying the results' do
        expect(rendered).to have_css('.book_reedition_title ul.autocomplete-result-list')
      end

      describe 'Stimulus' do
        subject { rendered }

        it { is_expected.to have_css('.book_reedition_title .autocomplete[data-controller="autocomplete"]') }
        it { is_expected.to have_css('input[name="book[reedition_id]"][data-target="autocomplete.value"]', visible: false) }
      end
    end
  end
end
