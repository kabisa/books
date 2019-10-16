require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  render_views

  describe 'GET #index' do
    def do_get
      get :index#, session: valid_session
    end

    it 'ransacks the Book model' do
      expect(Book).to receive(:ransack).and_call_original
      do_get
    end

    it 'assigns a `q` variable' do
      do_get
      expect(assigns[:q]).to be_a(Ransack::Search)
    end
  end
end

