class CommentsController < ApplicationController
  before_action :set_book, only: %i[index create]

  def index
    redirect_to @book
  end

  def create
    @comment = authorize Comment.new(comment_params).decorate

    if @comment.save
      notice = t('.notice')
      respond_to do |format|
        format.html { redirect_to @book, notice: notice }
        format.turbo_stream { flash.now[:notice] = notice }
      end
    else
      render 'books/show', status: :unprocessable_entity
    end
  end

  def destroy
    @comment = authorize Comment.find(params[:id]).decorate
    @book = @comment.book

    @comment.destroy
    notice = t('.notice')
    action = helpers.link_to(t('helpers.submit.undo'), restore_comment_path(@comment), method: :post,
                                                                                       data: { turbo_frame: '_top' })
    respond_to do |format|
      format.html do
        flash[:notice] = notice
        flash[:action] = action
        redirect_to @book
      end

      format.turbo_stream do
        flash.now[:notice] = notice
        flash.now[:action] = action
      end
    end
  end

  def restore
    @comment = authorize Comment.only_deleted.find(params[:id]).restore.decorate
    @book = @comment.book
    notice = t('.notice')

    respond_to do |format|
      format.html { redirect_to book_path(@book, anchor: @comment.dom_id), notice: notice }
      format.turbo_stream do
        flash.now[:notice] = notice
        render :destroy
      end
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
