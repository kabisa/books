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
    @book    = @comment.book

    @comment.destroy
    flash[:notice] = t('.notice')
    flash[:action] = helpers.link_to(t('helpers.submit.undo'), restore_comment_path(@comment), method: :post, remote: true)
    redirect_to @book
  end

  def restore
    @comment = authorize Comment.only_deleted.find(params[:id]).restore.decorate
    @book    = @comment.book
    redirect_to book_path(@book, anchor: @comment.dom_id), notice: t('.notice')
  end

  private

    def set_book
      @book = Book.find(params[:book_id]).decorate
    end

    def comment_params
      params.require(:comment).permit(:body).merge(user: current_user, book: @book)
    end
end
