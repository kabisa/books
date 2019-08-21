require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  render_views

  # This should return the minimal set of attributes required to create a valid
  # Book. As you add validations to Book, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  let(:current_user)       { create :user }
  let(:valid_session)      { { user_id: current_user.id } }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, session: valid_session
      expect(response).to be_successful
    end
  end

  xdescribe "GET #show" do
    it "returns a success response" do
      book = Book.create! valid_attributes
      get :show, params: {id: book.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    def do_get
      get :new, session: valid_session
    end

    it 'returns a success response' do
      do_get
      expect(response).to be_successful
    end

    it 'assigns an e-book' do
      do_get
      expect(assigns[:book]).to be_a(Ebook)
    end
  end

  xdescribe "GET #edit" do
    it "returns a success response" do
      book = Book.create! valid_attributes
      get :edit, params: {id: book.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  xdescribe "POST #create" do
    context "with valid params" do
      it "creates a new Book" do
        expect {
          post :create, params: {book: valid_attributes}, session: valid_session
        }.to change(Book, :count).by(1)
      end

      it "redirects to the created book" do
        post :create, params: {book: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Book.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {book: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  xdescribe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested book" do
        book = Book.create! valid_attributes
        put :update, params: {id: book.to_param, book: new_attributes}, session: valid_session
        book.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the book" do
        book = Book.create! valid_attributes
        put :update, params: {id: book.to_param, book: valid_attributes}, session: valid_session
        expect(response).to redirect_to(book)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        book = Book.create! valid_attributes
        put :update, params: {id: book.to_param, book: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  xdescribe "DELETE #destroy" do
    it "destroys the requested book" do
      book = Book.create! valid_attributes
      expect {
        delete :destroy, params: {id: book.to_param}, session: valid_session
      }.to change(Book, :count).by(-1)
    end

    it "redirects to the books list" do
      book = Book.create! valid_attributes
      delete :destroy, params: {id: book.to_param}, session: valid_session
      expect(response).to redirect_to(books_url)
    end
  end

end
