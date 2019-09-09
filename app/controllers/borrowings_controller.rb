class BorrowingsController < ApplicationController

  def create
    @book = Book.find(params[:book_id]).decorate
    @borrowing = authorize Borrowing.new(copy_id: params[:copy_id], user: current_user)

    respond_to do |format|
      if @borrowing.save
        format.html { redirect_to books_url }
        format.json { render :show, status: :created, location: @borrowing }
        format.js { render :update }
      else
        #format.html { render :new }
        #format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

end
