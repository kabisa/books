class CommentsController < ApplicationController
  before_action :set_book, only: [:index, :create]

  def index
    redirect_to @book
  end

  def create
    @comment = authorize Comment.new(comment_params)

    if @comment.save
      redirect_to @book, notice: t('.notice')
    else
      render 'books/show'
    end
  end


  def destroy
    @comment = authorize Comment.find(params[:id])
    @book = @comment.book
    @comment.destroy

    redirect_to @book, notice: t('.notice')
  end

  private

    def set_book
      @book = Book.find(params[:book_id]).decorate
    end

    def comment_params
      params.require(:comment).permit(:body).merge(user: current_user, book: @book)
    end
end
