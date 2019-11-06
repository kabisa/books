require 'rails_helper'

RSpec.describe CommentsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/books/1/comments').to route_to('comments#create', book_id: '1')
    end

    it 'routes to #index' do
      expect(get: '/books/1/comments').to route_to('comments#index', book_id: '1')
    end

    it 'routes to #destroy' do
    expect(delete: '/comments/1').to route_to('comments#destroy', id: '1')
    end
  end

  describe 'named routes' do
    let(:book) { create :book }

    it do
      expect(post: book_comments_path(book)).to route_to('comments#create', book_id: book.to_param)
    end
  end
end
