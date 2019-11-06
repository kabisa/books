class CommentsController < ApplicationController
  before_action :set_book, only: [:create]

  def create
    @comment = authorize Comment.new(comment_params)

    if @comment.save
      redirect_to @book
    else
      render 'books/show'
    end
  end

  private

    def set_book
      @book = Book.find(params[:book_id]).decorate
    end

    def comment_params
      params.require(:comment).permit(:body).merge(user: current_user, book: @book)
    end
end
