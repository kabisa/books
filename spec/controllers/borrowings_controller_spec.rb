require 'rails_helper'

RSpec.describe BorrowingsController, type: :controller do
  render_views
  let(:current_user)       { create :user }
  let(:valid_session)      { { user_id: current_user.id } }

  describe 'POST #create' do
    def do_post(attributes)
      post :create, xhr: true, params: attributes, session: valid_session
    end

    context 'with valid params' do
      let(:valid_attributes) {
        { book_id: book.id,
          copy_id: copy.id }
      }
      let(:copy) { book.copies.first }
      let(:book) { create(:printed_book) }

      it 'creates a new Borrowing' do
        expect {
          do_post(valid_attributes)
        }.to change(Borrowing, :count).by(1)
      end

      it 'assigns the book' do
        do_post(valid_attributes)
        expect(assigns[:book]).to eql(book)
      end

      it 'decorates the book' do
        do_post(valid_attributes)
        expect(assigns(:book)).to be_decorated
      end
    end
  end
end

