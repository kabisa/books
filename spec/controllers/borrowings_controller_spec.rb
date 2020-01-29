require 'rails_helper'

RSpec.describe BorrowingsController, type: :controller do
  render_views
  let(:current_user)       { create :user }
  let(:valid_session)      { { user_id: current_user.id } }

  describe 'POST #create' do
    def do_post(attributes, xhr: true)
      post :create, xhr: xhr, params: attributes, session: valid_session
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

      context 'synchronous' do
        it 'sets a flash notice' do
          do_post(valid_attributes, xhr: false)
          expect(request.flash.notice).to match(/You're now borrowing/)
        end

        it 'redirects to /books/:id' do
          do_post(valid_attributes, xhr: false)
          expect(response).to redirect_to(book)
        end
      end

      context 'asynchronous' do
        it 'sets a flash notice' do
          do_post(valid_attributes)
          expect(request.flash.notice).to match(/You're now borrowing/)
        end

        it 'renders create' do
          do_post(valid_attributes)
          expect(response).to render_template(:create)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:copy)       { book.copies.first }
    let(:book)       { create(:book, :printed_book) }

    def do_delete(id, xhr: true)
      delete :destroy, xhr: xhr, params: {id: id}, session: valid_session
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

      context 'synchronous' do
        it 'sets a flash notice' do
          do_delete(borrowing.to_param, xhr: false)
          expect(request.flash.notice).to match(/Thank you for returning/)
        end

        it 'redirects to /books/:id' do
          do_delete(borrowing.to_param, xhr: false)
          expect(response).to redirect_to(book)
        end
      end

      context 'asynchronous' do
        it 'sets a flash notice' do
          do_delete(borrowing.to_param)
          expect(request.flash.notice).to match(/Thank you for returning/)
        end

        it 'renders create' do
          do_delete(borrowing.to_param)
          expect(response).to render_template(:create)
        end
      end
    end
  end
end

