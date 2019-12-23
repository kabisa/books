require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # Book. As you add validations to Book, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    attributes_for(:book)
  }

  let(:invalid_attributes) {
    attributes_for(:ebook, :invalid)
  }

  let(:current_user)       { create :user }
  let(:valid_session)      { { user_id: current_user.id } }

  describe 'GET #index' do
    def do_get
      get :index, session: valid_session
    end

    let(:search_spy) do
      #Ransack::Search.new(Book, nil)
      spy('Ransack::Search')
    end

    it 'returns a success response' do
      do_get
      expect(response).to be_successful
    end

    it 'decorates the collection' do
      do_get
      expect(assigns(:books)).to be_decorated
    end

    it 'ransacks the Book model' do
      expect(Book).to receive(:ransack).and_call_original
      do_get
    end

    it 'avoids N+1 queries' do
      allow(Book).to receive(:ransack).and_return(search_spy)
      expect(search_spy.result).to receive(:includes).with(:taggings, :writers, copies: [:location])
      do_get
    end

    it 'assigns a `q` variable' do
      do_get
      expect(assigns[:q]).to be_a(Ransack::Search)
    end
  end

  describe 'GET #show' do
    def do_get
      get :show, params: {id: book.to_param}, session: valid_session
    end

    let!(:book) { create :book }

    it 'returns a success response' do
      do_get
      expect(response).to be_successful
    end

    it 'decorates the book' do
      do_get
      expect(assigns(:book)).to be_decorated
    end

    it 'assigns a `comment` variable' do
      do_get
      expect(assigns[:comment]).to be_a(Comment)
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

    it 'adds a location to the book' do
      do_get
      expect(assigns[:book]).to have(1).copy
    end
  end

  describe "GET #edit" do
    let!(:book) { create :book }

    it "returns a success response" do
      get :edit, params: {id: book.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    def do_post(attributes)
      post :create, params: {book: attributes}, session: valid_session
    end

    context 'e-book' do
      context 'with valid params' do
        let(:valid_attributes) {
          attributes_for(:ebook)
        }

        let(:invalid_attributes) {
          attributes_for(:ebook, :invalid)
        }

        it 'creates a new Ebook' do
          expect {
            do_post(valid_attributes)
          }.to change(Ebook, :count).by(1)
        end

        it 'redirects to the created book' do
          do_post(valid_attributes)
          expect(response).to redirect_to(Ebook.last)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'new' template)" do
          do_post(invalid_attributes)
          expect(response).to be_successful
        end

        it 'renders the new template' do
          do_post(invalid_attributes)
          expect(response).to render_template(:new)
        end
      end
    end

    context 'printed book' do
      context 'with valid params' do
        let(:valid_attributes) {
          attributes_for(:ebook)
        }

        let(:invalid_attributes) {
          attributes_for(:e_book, :invalid)
        }

        it 'creates a new Ebook' do
          expect {
            do_post(valid_attributes)
          }.to change(Ebook, :count).by(1)
        end

        it 'redirects to the created book' do
          do_post(valid_attributes)
          expect(response).to redirect_to(Ebook.last)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'new' template)" do
          do_post(invalid_attributes)
          expect(response).to be_successful
        end

        it 'renders the new template' do
          do_post(invalid_attributes)
          expect(response).to render_template(:new)
        end
      end
    end
  end

  describe "PUT #update" do
    let!(:book) { create :book }

    def do_put(attributes)
      put :update, params: {id: book.to_param, book: attributes}, session: valid_session
    end

    context "with valid params" do
      let(:new_attributes) { attributes_for(:book) }

      it "updates the requested book" do
        do_put(new_attributes)
        book.reload
      end

      it "redirects to the book" do
        do_put(new_attributes)
        expect(response).to redirect_to(book)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        do_put(invalid_attributes)
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:book) { create :book }

    it 'destroys the requested book' do
      expect {
        delete :destroy, params: {id: book.to_param}, session: valid_session
      }.to change(Book, :count).by(-1)
    end

    it 'redirects to the books list' do
      delete :destroy, params: {id: book.to_param}, session: valid_session
      expect(response).to redirect_to(books_url)
    end
  end

  describe 'POST #restore' do
    before { book.destroy }

    let!(:book) { create :book }

    def do_post(id)
      post :restore, xhr: true, params: {id: id}, session: valid_session
    end

    it 'restores the requested book' do
      expect {
        do_post(book.to_param)
      }.to change(Book, :count).by(1)
    end

    it 'sets a flash notice' do
      do_post(book.to_param)
      expect(request.flash.notice).to match('Action undone.')
    end
  end
end
