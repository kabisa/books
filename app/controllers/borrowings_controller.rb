class BorrowingsController < ApplicationController
  before_action :cast_show_param

  def create
    @book = Book.find(params[:borrowing][:book_id]).decorate
    copy = Copy.find(params.dig(:borrowing, :copy_id))
    borrowing = authorize copy.borrowings.build(user: current_user)
    @comment = Comment.new

    respond_to do |format|
      if borrowing.save
        notice = t('.notice', title: @book.title)
        format.turbo_stream { flash.now[:notice] = notice }
      else
        #format.html { render :new }
        #format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    borrowing = authorize Borrowing.find(params[:id])
    @book = borrowing.copy.book.decorate
    @comment = Comment.new

    respond_to do |format|
      if borrowing.really_destroy!
        notice = t('.notice', title: @book.title)
        format.turbo_stream do
          flash.now[:notice] = notice
          render :create
        end
      else
        #format.html { render :new }
        #format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def cast_show_param
    @show = ActiveModel::Type::Boolean.new.cast(params[:show])
  end
end
