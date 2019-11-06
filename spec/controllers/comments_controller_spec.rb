require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  render_views
  let(:current_user)  { create :user }
  let(:valid_session) { { user_id: current_user.id } }
  let(:book)          { create(:printed_book) }

  describe 'GET #index' do
    def do_get
      get :index, params: { book_id: book.id }, session: valid_session
    end

    it 'redirects to /books/:book_id' do
      do_get
      expect(response).to redirect_to(book)
    end
  end

  describe 'POST #create' do
    def do_post(attributes)
      post :create, params: attributes, session: valid_session
    end

    context 'with valid params' do
      let(:attributes) {
        {
          book_id: book.id,
          comment: { body: 'Lorem Ipsum' }
        }
      }

      it 'creates a new Comment' do
        expect {
          do_post(attributes)
        }.to change(book.comments, :count).by(1)
      end

      it 'references the current user' do
        do_post(attributes)
        expect(Comment.last.user).to be_eql(current_user)
      end

      it 'assigns the book' do
        do_post(attributes)
        expect(assigns[:book]).to eql(book)
      end

      it 'decorates the book' do
        do_post(attributes)
        expect(assigns(:book)).to be_decorated
      end

      it 'sets the flash notice' do
        do_post(attributes)
        expect(request.flash.notice).not_to be_empty
      end

      it 'redirect to /books/:book_id' do
        do_post(attributes)
        expect(response).to redirect_to(book)
      end
    end

    context 'with invalid params' do
      let(:attributes) {
        {
          book_id: book.id,
          comment: { body: '' }
        }
      }

      it 'does not create a new Comment' do
        expect {
          do_post(attributes)
        }.not_to change(Comment, :count)
      end

      it 'assigns the book' do
        do_post(attributes)
        expect(assigns[:book]).to eql(book)
      end

      it 'decorates the book' do
        do_post(attributes)
        expect(assigns(:book)).to be_decorated
      end

      it 'renders books#show' do
        do_post(attributes)
        expect(response).to render_template('books/show')
      end
    end
  end

end
