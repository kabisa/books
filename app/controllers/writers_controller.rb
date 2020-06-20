class WritersController < ApplicationController
  # GET /writers
  # GET /writers.json
  def index
    @writers =
      Writer.with_books.includes(:books).order(:name).page(params[:page])
        .decorate
  end
end
