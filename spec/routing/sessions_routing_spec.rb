require 'rails_helper'

RSpec.describe 'routes for sessions', type: :routing do
  describe 'GET /sign_in' do
    it { expect(get('sign_in')).to route_to('sessions#new') }

    it { expect(get: sign_in_path).to route_to('sessions#new') }
  end

  describe 'POST /sign_in' do
    it { expect(post('sign_in')).to route_to('sessions#create') }
  end

  describe 'GET /sign_in/:token' do
    it { expect(get('sign_in/some_token')).to route_to(controller: 'sessions', action: 'show', token: 'some_token') }

    it { expect(get: token_sign_in_path('some_token')).to route_to(controller: 'sessions', action: 'show', token: 'some_token') }
  end

  describe 'DELETE /sign_out' do
    it { expect(delete('sign_out')).to route_to('sessions#destroy') }

    it { expect(delete: sign_out_path).to route_to('sessions#destroy') }
  end
end
