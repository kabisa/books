class BorrowingsController < ApplicationController

  def create
    @book     = Book.find(params[:book_id]).decorate
    copy      = Copy.find(params[:copy_id])
    borrowing = authorize copy.borrowings.build(user: current_user)

    respond_to do |format|
      if borrowing.save
        format.js { render :update }
      else
        #format.html { render :new }
        #format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

end
