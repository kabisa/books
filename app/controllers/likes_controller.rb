class LikesController < ApplicationController
  before_action :set_book, only: [:create]
  before_action :set_vote, only: [:destroy]

  def create
    @vote = authorize @book.votes.find_or_initialize_by(user: current_user)
    @vote.like = true
    @vote.dislike = nil

    if @vote.save
      respond_to do |format|
        flash.now.notice = t('.notice')
        format.js
      end
    end
  end

  def destroy
    @book = authorize @vote.book.decorate

    @vote.destroy
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
end
