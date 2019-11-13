class WelcomeController < ApplicationController
  def index
    @q = ransack_params

    @last_commented_on = Comment.order(:created_at).last.book.decorate
    @recently_added = Book.order(:created_at).last.decorate
    @most_likes = Book.order(:likes_count).last.decorate
  end
end
