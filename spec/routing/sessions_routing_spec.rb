require 'rails_helper'

RSpec.describe 'routes for sessions', type: :routing do
  describe 'GET /sign_in' do
    it { expect(get('sign_in')).to route_to('sessions#new') }

    it { expect(get: signin_path).to route_to('sessions#new') }
  end

  describe 'POST /sign_in' do
    xit { expect(post('sign_in')).to route_to('sessions#create') }
  end
end

