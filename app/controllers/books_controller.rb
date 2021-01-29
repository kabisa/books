class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]
  skip_after_action :verify_authorized, only: %i[show]

  # GET /books
  # GET /books.json
  def index
    @q =
      BookSearch.search(params) do |q|
        @books =
          q.result(distinct: true).complement_with(id: params[:restorable_id])
            .includes(
            :reedition,
            :taggings,
            :writers,
            :previous_editions,
            copies: %i[location]
          ).page(params[:page]).decorate
      end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @comment = Comment.new
  end

  # GET /books/new
  def new
    @book = authorize Book.new
    @book.copies.build(number: 1)
  end

  # GET /books/1/edit
  def edit; end

  # POST /books
  # POST /books.json
  def create
    @book = authorize Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html do
          redirect_to @book, notice: 'Book was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      notice = t('.notice', title: @book.title)
      action =
        helpers.link_to(
          t('helpers.submit.undo'),
          restore_book_path(@book),
          method: :post, remote: true
        )

      format.html do
        flash[:action] = action
        redirect_to books_url(restorable_id: @book), notice: notice
      end
      format.json { head :no_content }
      format.js do
        flash.now[:action] = action
        flash.now.notice = notice
      end
    end
  end

  def restore
    @book =
      authorize Book.only_deleted.find(params[:id]).restore(recursive: true)
                  .decorate

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
    permitted_attributes(Book)
  end
end
