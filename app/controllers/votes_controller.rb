class VotesController < ApplicationController
  before_action :set_book, only: [:create]
  before_action :set_vote, only: [:destroy]

  def create
    Vote.transaction do
      if (dislike = votes[:previous].find_by(user: current_user))
        authorize dislike.really_destroy!
      end

      @vote = authorize votes[:current].create(user: current_user)
    end

    if @vote.valid?
      respond_to do |format|
        flash.now.notice = t('.notice')
        format.js
      end
    end
  end

  def destroy
    authorize @vote.really_destroy!
    @book = @vote.book.decorate

    respond_to do |format|
      flash.now.notice = t('.notice')
      format.js
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_vote
    @vote = Vote.find(params[:id])
  end

  def set_book
    @book = Book.find(params[:book_id]).decorate
  end

  def votes
    case params[:type]
    when 'Like'
      { previous: dislikes,
        current: likes }
    when 'Dislike'
      { previous: likes,
        current: dislikes }
    end
  end

  delegate :likes, :dislikes, to: :@book
end
