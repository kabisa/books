require 'rails_helper'

RSpec.describe VotesController, type: :routing do
  describe 'routing' do
    describe 'likes' do
      it 'routes to #create' do
        expect(post: '/books/1/likes').to route_to('votes#create', book_id: '1', type: 'Like')
      end

      it 'routes to #destroy' do
        expect(delete: '/likes/1').to route_to('votes#destroy', id: '1', type: 'Like')
      end
    end

    describe 'dislikes' do
      it 'routes to #create' do
        expect(post: '/books/1/dislikes').to route_to('votes#create', book_id: '1', type: 'Dislike')
      end

      it 'routes to #destroy' do
        expect(delete: '/dislikes/1').to route_to('votes#destroy', id: '1', type: 'Dislike')
      end
    end
  end

  describe 'named routes' do
    let(:book) { create :book }

    it do
      expect(post: book_likes_path(book)).to route_to('votes#create', type: 'Like', book_id: book.to_param)
    end

    it do
      expect(post: book_dislikes_path(book)).to route_to('votes#create', type: 'Dislike', book_id: book.to_param)
    end
  end
end
