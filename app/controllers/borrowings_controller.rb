class BorrowingsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :select_copy

  def create
    @book     = Book.find(params[:borrowing][:book_id]).decorate
    copy      = Copy.find(params.dig(:borrowing, :copy_id))
    borrowing = authorize copy.borrowings.build(user: current_user)

    respond_to do |format|
      if borrowing.save
        flash.now.notice = t('.notice', title: @book.title)
        format.js { render :create }
      else
        #format.html { render :new }
        #format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    borrowing = authorize Borrowing.find(params[:id])
    @book = borrowing.copy.book.decorate

    respond_to do |format|
      if borrowing.really_destroy!
        flash.now.notice = t('.notice', title: @book.title)
        format.js { render :create }
      else
        #format.html { render :new }
        #format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def select_copy
    render :select_copy
  end
end
