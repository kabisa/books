class LikesController < ApplicationController
  before_action :set_book, only: [:create]

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

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:book_id]).decorate
  end
end
