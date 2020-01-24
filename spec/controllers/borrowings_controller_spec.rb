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
        {
          borrowing:
          { book_id: book.id,
            copy_id: copy.id }
        }
      }
      let(:copy) { book.copies.first }
      let(:book) { create(:book, :printed_book) }

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

      it 'sets a flash notice' do
        do_post(valid_attributes)
        expect(request.flash.notice).to match(/You're now borrowing/)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:copy)       { book.copies.first }
    let(:book)       { create(:book, :printed_book) }

    def do_delete(id)
      delete :destroy, xhr: true, params: {id: id}, session: valid_session
    end

    context 'user returns his/her book' do
      let!(:borrowing) { create :borrowing, copy: copy, user: current_user }

      it 'destroys the requested borrowing' do
        expect {
          do_delete(borrowing.to_param)
        }.to change(Borrowing, :count).by(-1)
      end

      it 'assigns the book' do
        do_delete(borrowing.to_param)
        expect(assigns[:book]).to eql(book)
      end

      it 'decorates the book' do
        do_delete(borrowing.to_param)
        expect(assigns(:book)).to be_decorated
      end

      it 'sets a flash notice' do
        do_delete(borrowing.to_param)
        expect(request.flash.notice).to match(/Thank you for returning/)
      end
    end
  end
end

