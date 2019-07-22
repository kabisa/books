require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  render_views

  let(:email) { 'john.doe@example.com' }

  describe 'POST /sessions' do
    describe 'on success' do
      let(:options) do
        {
          email: email
        }
      end

      def do_post(params=options)
        post :create, params: params
      end

      context 'new user' do
        it 'creates the user' do
          expect do
            do_post
          end.to change { User.count }.by(1)
        end

        it 'assigns the email address' do
          do_post
          expect(User.first.email).to eql(email)
        end

        it 'sets the login token' do
          do_post
          expect(User.first.login_token).not_to be_nil
        end

        it 'expires in some time' do
          do_post
          expect(User.first.login_token_valid_until).to be_within(1.second).of(30.minutes.from_now)
        end

        it 'sends a mail' do
          expect(SessionsMailer).to receive_message_chain(:magic_link, :deliver)
          do_post
        end

        it 'renders the create template' do
          expect(do_post).to render_template(:create)
        end
      end

      context 'existing user' do
        before do
          create(:user, email: email)
        end

        it 'does not create a user' do
          expect do
            do_post.not_to change { User.count }
          end
        end

        it 'sets the login token' do
          do_post
          expect(User.first.login_token).not_to be_nil
        end

        it 'expires in some time' do
          do_post
          expect(User.first.login_token_valid_until).to be_within(1.second).of(30.minutes.from_now)
        end

        it 'sends a mail' do
          expect(SessionsMailer).to receive_message_chain(:magic_link, :deliver)
          do_post
        end

        it 'renders the create template' do
          expect(do_post).to render_template(:create)
        end
      end
    end

    context 'on failure' do
      context 'invalid email address' do

      end
    end
  end

  describe 'GET sessions/:token' do
    let(:login_token) { 'lorem-ipsum' }

    describe 'on success' do
      let!(:user) do
        create :user
      end

      def do_get
        get 'show', params: {
          token: login_token
        }
      end

      it 'resets the token' do
        expect do
          do_get
          user.reload
        end.to change { user.login_token }.to(nil).and \
               change { user.login_token_valid_until }
      end

      it 'assigns the user' do
        do_get
        expect(controller.current_user).to eql(user)
      end

      it 'redirects to the root page' do
        expect(do_get).to redirect_to(root_path)
      end
    end
  end

  describe 'DELETE sessions' do
    before { controller.current_user = build_stubbed(:user) }

    def do_delete
      delete 'destroy'
    end

    it 'nullifies the current user' do
      do_delete
      expect(controller.current_user).to be_anonymous
    end

    it 'redirect to the root path' do
      expect(do_delete).to redirect_to(root_path)
    end
  end
end
