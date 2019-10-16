class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  skip_after_action :verify_authorized, only: %i(show)

  # GET /books
  # GET /books.json
  def index
    @q = Book.ransack(params[:q])
    @books = @q.result.includes(copies: [:location]).decorate
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = authorize Ebook.new
    @book.copies.build(number: 1)
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = authorize book_class.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      flash.now.notice = t('.notice', title: @book.title)
      format.html { redirect_to books_url }
      format.json { head :no_content }
      format.js
    end
  end

  def restore
    @book = authorize Book.only_deleted.find(params[:id]).restore(recursive: true).decorate

    respond_to do |format|
      flash.now.notice = t('.notice')
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = authorize Book.find(params[:id]).decorate
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :link, :summary, copies_attributes: [:id, :location_id, :number, :_destroy])
    end

    def book_class
      BookType.book_class(params[:book][:type])
    end
end
